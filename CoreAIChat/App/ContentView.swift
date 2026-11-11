//
//  ContentView.swift
//  CoreAIChat
//
//  Created by Timo Köthe on 09.06.26.
//

import SwiftUI

struct ContentView: View {
    @State private var inference: InferenceService
    @State private var vm: ChatViewModel

    init() {
        let inference = InferenceService()
        _inference = State(initialValue: inference)
        _vm = State(initialValue: ChatViewModel(inference: inference))
    }
    
    var body: some View {
        VStack {
            switch inference.status {
            case .missingResources:
                ErrorView(
                    title: "Model Resources Missing",
                    description: "Copy the complete exported model resources, including metadata.json, into the project's model/ folder, then rebuild and run the app. See Getting Started in README.md for instructions.",
                    icon: "folder.badge.questionmark"
                )
            case .failed(let error):
                ErrorView(
                    title: "Error",
                    description: error.localizedDescription,
                    icon: "nosign",
                    retry: {
                        Task {
                            await inference.loadModel()
                        }
                    }
                )
            case .loading:
                ProgressView("Loading Model...")
            case .unloaded:
                ModelSetupView {
                    await inference.loadModel()
                }
            case .ready:
                ChatView(vm: vm)
            }
        }
        .frame(minWidth: 450, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
