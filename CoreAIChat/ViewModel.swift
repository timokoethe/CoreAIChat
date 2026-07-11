//
//  ViewModel.swift
//  CoreAIChat
//
//  Created by Timo Köthe on 09.06.26.
//

import FoundationModels
import Observation
import Foundation
import CoreAILanguageModels

@MainActor
@Observable
final class ViewModel {
    private var session: LanguageModelSession?
    private let modelUrl: URL? = Bundle.main.url(forResource: "gemma_3_4b_it_4bit_dynamic", withExtension: nil)
    
    var status: ModelState = .unloaded
    
    var draft: String = ""
    var prompt: String = ""
    var isResponding: Bool = false
    var messages: [Message] = []
    
    
    func loadSession() async {
        self.status = .loading
        
        guard let modelUrl = modelUrl else {
            status = .failed(URLError(.badURL))
            return
        }

        do {
            let model = try await CoreAILanguageModel(resourcesAt: modelUrl)
            self.session = LanguageModelSession(model: model)
            self.session!.prewarm()
        } catch {
            print(error.localizedDescription)
            self.status = .failed(error)
            return
        }
        
        self.status = .ready
    }
    
    func getResponse() async {
        let submittedPrompt = draft.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !isResponding, !submittedPrompt.isEmpty else {
            return
        }

        guard let session else {
            status = .failed(URLError(.badServerResponse))
            return
        }

        isResponding = true
        defer { isResponding = false }
        
        messages.append(Message(role: .user, text: submittedPrompt))
        prompt = submittedPrompt
        draft = ""
        do {
            let response = try await session.respond(to: prompt)
            let message = Message(role: .assistant, text: response.content)
            messages.append(message)
        } catch {
            let message = Message(role: .assistant, text: error.localizedDescription)
            messages.append(message)
        }
    }
}

enum ModelState {
    case unloaded
    case loading
    case ready
    case failed(Error)
}
