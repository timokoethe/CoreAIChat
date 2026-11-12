//
//  Typebar.swift
//  CoreAIChat
//
//  Created by Timo Köthe on 12.06.26.
//

import SwiftUI

struct Typebar: View {
    @Bindable var vm: ChatViewModel
    @State private var selection: TextSelection?

    private var canSend: Bool {
        !vm.isResponding
            && !vm.draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        HStack(alignment: .bottom) {
            TextField("Type here ...", text: $vm.draft, selection: $selection, axis: .vertical)
                .lineLimit(1...6)
                .padding(.horizontal, 6)
                .textFieldStyle(.plain)
                .padding(8)
                .glassEffect(in: .rect(cornerRadius: 18))
                .accessibilityLabel("Message")
                .help("Return sends the message. Shift-Return inserts a new line.")
                .onKeyPress(.return, phases: .down) { press in
                    if press.modifiers == .shift {
                        insertNewline()
                        return .handled
                    }
                    guard press.modifiers.isEmpty else { return .ignored }
                    sendMessage()
                    return .handled
                }

            Button(role: .confirm, action: sendMessage) {
                ZStack {
                    Color.clear

                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 17, height: 17)
                }
                .frame(width: 32, height: 32)
                .contentShape(.circle)
                .glassEffect(in: .circle)
            }
            .buttonStyle(.plain)
            .help("Send message (Return)")
            .accessibilityLabel("Send message")
            .foregroundStyle(canSend ? Color.accentColor : Color.secondary)
            .disabled(!canSend)
        }
        .padding(6)
        .frame(maxWidth: 700)
    }

    private func insertNewline() {
        let range: Range<String.Index>
        if let selection, case .selection(let selectedRange) = selection.indices {
            range = selectedRange
        } else {
            range = vm.draft.endIndex..<vm.draft.endIndex
        }

        let insertionOffset = range.lowerBound.utf16Offset(in: vm.draft)
        vm.draft.replaceSubrange(range, with: "\n")
        selection = TextSelection(insertionPoint: String.Index(
            utf16Offset: insertionOffset + 1, in: vm.draft
        ))
    }

    private func sendMessage() {
        guard canSend else { return }
        Task {
            await vm.getResponse()
        }
    }
}

#Preview() {
    Typebar(vm: ChatViewModel())
}
