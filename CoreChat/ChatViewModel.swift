//
//  ChatViewModel.swift
//  CoreChat
//
//  Created by Timo Köthe on 09.06.26.
//

import FoundationModels
import Observation

@MainActor
@Observable
final class ChatViewModel {
    var messages: [ChatMessage] = []
    var input: String = ""
    var isResponding = false

    /// `nil` while the model is available; otherwise a short, user-facing reason.
    let unavailableReason: String?

    private let session: LanguageModelSession?

    init() {
        switch SystemLanguageModel.default.availability {
        case .available:
            unavailableReason = nil
            session = LanguageModelSession(
                instructions: "You are a concise, helpful assistant."
            )
        case .unavailable(let reason):
            session = nil
            unavailableReason = Self.describe(reason)
        }
    }

    var canSend: Bool {
        session != nil && !isResponding
            && !input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func send() async {
        guard let session else { return }

        let prompt = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !prompt.isEmpty else { return }

        input = ""
        messages.append(ChatMessage(role: .user, text: prompt))

        isResponding = true
        defer { isResponding = false }

        do {
            let response = try await session.respond(to: prompt)
            messages.append(ChatMessage(role: .assistant, text: response.content))
        } catch {
            messages.append(
                ChatMessage(role: .assistant, text: "⚠️ \(error.localizedDescription)")
            )
        }
    }

    private static func describe(
        _ reason: SystemLanguageModel.Availability.UnavailableReason
    ) -> String {
        switch reason {
        case .deviceNotEligible:
            return "This device does not support Apple Intelligence."
        case .appleIntelligenceNotEnabled:
            return "Please enable Apple Intelligence in System Settings."
        case .modelNotReady:
            return "The model is still loading. Please try again later."
        @unknown default:
            return "The language model is currently unavailable."
        }
    }
}
