//
//  ModelSetupView.swift
//  CoreAIChat
//
//  Created by Codex on 21.09.26.
//

import SwiftUI

struct ModelSetupView: View {
    let loadModel: () async -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cpu")
                .font(.system(size: 28, weight: .medium))
                .foregroundStyle(.tint)
                .frame(width: 56, height: 56)
                .background(.tint.opacity(0.12), in: .circle)

            VStack(spacing: 6) {
                Text("Chat Locally")
                    .font(.title2.weight(.semibold))

                Text("Load the bundled model to start a private, on-device conversation.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 340)
            }

            Button("Load Model") {
                Task {
                    await loadModel()
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding(40)
    }
}

#Preview {
    ModelSetupView {}
        .frame(width: 720, height: 560)
}
