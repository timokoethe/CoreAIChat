import Foundation
import Observation

/// Owns the visible conversation and draft; inference owns the model context.
@MainActor
@Observable
final class ChatViewModel {
    private let inference: InferenceService

    var draft: String = ""
    var isResponding: Bool = false
    var messages: [Message] = []

    convenience init() {
        self.init(inference: InferenceService())
    }

    init(inference: InferenceService) {
        self.inference = inference
    }

    func getResponse() async {
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
        defer { isResponding = false }
        
        messages.append(Message(role: .user, text: submittedPrompt))
        draft = ""
        do {
            let response = try await inference.respond(to: submittedPrompt)
            let message = Message(role: .assistant, text: response)
            messages.append(message)
        } catch {
            let message = Message(role: .assistant, text: error.localizedDescription)
            messages.append(message)
        }
    }
}
