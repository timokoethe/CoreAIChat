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
            case .failed(let error):
                ErrorView(title: "Error", description: error.localizedDescription, icon: "nosign")
            case .loading:
                ProgressView("Loading Model...")
            case .unloaded:
                Button("Load Model") {
                    Task {
                        await vm.loadSession()
                    }
                }
            case .ready:
                ChatView(vm: vm)
            }
        }
        .frame(width: 450, height: 300)
    }
}

#Preview {
    ContentView()
}
