//
//  ContentView.swift
//  CoreAIChat
//
//  Created by Timo Köthe on 09.06.26.
//

import SwiftUI

struct ContentView: View {
    @State private var vm: ViewModel = ViewModel()
    
    var body: some View {
        VStack {
            switch vm.status {
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
                            await vm.loadSession()
                        }
                    }
                )
            case .loading:
                ProgressView("Loading Model...")
            case .unloaded:
                ModelSetupView {
                    await vm.loadSession()
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
