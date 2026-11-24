import Foundation
import Observation

/// Owns the visible conversation and draft; inference owns the model context.
@MainActor
@Observable
final class ChatViewModel {
    private let inference: InferenceService
    @ObservationIgnored private var responseTask: Task<Void, Never>?

    var draft: String = ""
    var isResponding: Bool = false
    var messages: [Message] = []

    convenience init() {
        self.init(inference: InferenceService())
    }

    init(inference: InferenceService) {
        self.inference = inference
    }

    func startNewConversation() {
        guard !isResponding else { return }

        do {
            try inference.startNewConversation()
            messages.removeAll()
            draft = ""
        } catch {
            // Inference exposes the failure through the root loading error view.
            return
        }
    }

    func sendMessage() {
        let submittedPrompt = draft.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !isResponding, !submittedPrompt.isEmpty else {
            return
        }

        do {
            try inference.validateSession()
        } catch {
            return
        }

        isResponding = true
        messages.append(Message(role: .user, text: submittedPrompt))
        draft = ""
        responseTask = Task {
            await generateResponse(to: submittedPrompt)
        }
    }

    func cancelResponse() {
        responseTask?.cancel()
    }

    private func generateResponse(to prompt: String) async {
        defer {
            responseTask = nil
            isResponding = false
        }

        do {
            try Task.checkCancellation()
            let response = try await inference.respond(to: prompt)
            try Task.checkCancellation()
            let message = Message(role: .assistant, text: response)
            messages.append(message)
        } catch is CancellationError {
            return
        } catch {
            guard !Task.isCancelled else { return }
            let message = Message(role: .assistant, text: error.localizedDescription)
            messages.append(message)
        }
    }
}
