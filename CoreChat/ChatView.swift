//
//  ChatView.swift
//  CoreChat
//
//  Created by Timo Köthe on 09.06.26.
//

import SwiftUI

struct ChatView: View {
    @State private var vm = ChatViewModel()

    var body: some View {
        VStack(spacing: 0) {
            if let reason = vm.unavailableReason {
                ContentUnavailableView(
                    "No Language Model",
                    systemImage: "sparkles",
                    description: Text(reason)
                )
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(vm.messages) { message in
                            MessageBubble(message: message)
                        }
                    }
                    .padding()
                }
                .defaultScrollAnchor(.bottom)

                Divider()

                HStack(spacing: 8) {
                    TextField("Message…", text: $vm.input, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(1...5)
                        .onSubmit(submit)

                    Button(action: submit) {
                        if vm.isResponding {
                            ProgressView().controlSize(.small)
                        } else {
                            Image(systemName: "arrow.up.circle.fill").font(.title2)
                        }
                    }
                    .buttonStyle(.plain)
                    .disabled(!vm.canSend)
                }
                .padding()
            }
        }
        .navigationTitle("CoreChat")
    }

    private func submit() {
        guard vm.canSend else { return }
        Task { await vm.send() }
    }
}

private struct MessageBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.role == .user { Spacer(minLength: 40) }

            Text(message.text)
                .textSelection(.enabled)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(bubbleColor, in: .rect(cornerRadius: 16))
                .foregroundStyle(message.role == .user ? .white : .primary)

            if message.role == .assistant { Spacer(minLength: 40) }
        }
    }

    private var bubbleColor: Color {
        message.role == .user ? .accentColor : Color(.windowBackgroundColor)
    }
}

#Preview {
    ChatView()
}
