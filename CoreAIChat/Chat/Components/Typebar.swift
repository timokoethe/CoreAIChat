//
//  Typebar.swift
//  CoreAIChat
//
//  Created by Timo Köthe on 12.06.26.
//

import SwiftUI

struct Typebar: View {
    @Bindable var vm: ViewModel

    private var canSend: Bool {
        !vm.isResponding
            && !vm.draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        HStack {
            TextField("Type here ...", text: $vm.draft)
                .padding(.horizontal, 6)
                .textFieldStyle(.plain)
                .padding(8)
                .glassEffect()
                .onSubmit {
                    guard canSend else { return }
                    Task {
                        await vm.getResponse()
                    }
                }

            Button(role: .confirm) {
                Task {
                    await vm.getResponse()
                }
            } label: {
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
            .foregroundStyle(canSend ? Color.accentColor : Color.secondary)
            .allowsHitTesting(canSend)
        }
        .padding(6)
        .frame(maxWidth: 700)
    }
}

#Preview() {
    Typebar(vm: ViewModel())
}
