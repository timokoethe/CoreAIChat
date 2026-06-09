//
//  ChatViewModel.swift
//  CoreChat
//
//  Created by Timo Köthe on 09.06.26.
//

import FoundationModels
import Observation
import Foundation

@MainActor
@Observable
final class ChatViewModel {
    var messages: [Message] = []
    var input: String = ""
    var isResponding = false
    private var session: LanguageModelSession
    
    init() {
        self.session = LanguageModelSession(instructions: "Act as the best buddy.")
    }

    func getResponse() async {
        isResponding = true
        messages.append(Message(role: .user, text: input))
        let prompt = input
        input = ""
        do {
            let response = try await session.respond(to: prompt).content
            let message = Message(role: .assistant, text: response)
            messages.append(message)
        } catch {
            let message = Message(role: .assistant, text: error.localizedDescription)
            messages.append(message)
        }
        isResponding = false
    }
}
