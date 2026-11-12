import CoreAILanguageModels
import Foundation
import FoundationModels
import Observation

/// Owns the local model session and keeps runtime APIs out of the chat feature.
@MainActor
@Observable
final class InferenceService {
    private var model: CoreAILanguageModel?
    private var session: LanguageModelSession?
    private let modelUrl: URL? = Bundle.main.url(forResource: "model", withExtension: nil)

    private(set) var status: ModelState = .unloaded

    private var hasModelResources: Bool {
        guard let modelUrl else { return false }
        return FileManager.default.fileExists(atPath: modelUrl.appending(path: "metadata.json").path)
    }

    init() {
        if !hasModelResources {
            status = .missingResources
        }
    }
    
    func loadModel() async {
        self.status = .loading
        
        guard hasModelResources, let modelUrl else {
            status = .missingResources
            return
        }

        do {
            let model = try await CoreAILanguageModel(resourcesAt: modelUrl)
            try await model.load()
            let session = LanguageModelSession(model: model)
            session.prewarm()
            self.model = model
            self.session = session
        } catch {
            print(error.localizedDescription)
            self.status = .failed(error)
            return
        }
        
        self.status = .ready
    }

    func startNewConversation() throws {
        try validateSession()
        guard let model else {
            let error = URLError(.badServerResponse)
            status = .failed(error)
            throw error
        }
        session = LanguageModelSession(model: model)
    }
    
    /// Checks availability before the chat commits a submitted draft.
    func validateSession() throws {
        guard session != nil else {
            let error = URLError(.badServerResponse)
            status = .failed(error)
            throw error
        }
    }

    func respond(to prompt: String) async throws -> String {
        guard let session else {
            let error = URLError(.badServerResponse)
            status = .failed(error)
            throw error
        }

        let response = try await session.respond(to: prompt)
        return response.content
    }
}
