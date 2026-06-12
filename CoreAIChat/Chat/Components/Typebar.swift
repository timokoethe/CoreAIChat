//
//  Typebar.swift
//  CoreAIChat
//
//  Created by Timo Köthe on 12.06.26.
//

import SwiftUI

struct Typebar: View {
    @Bindable var vm: ViewModel
    var body: some View {
        HStack {
            TextField("Type here ...", text: $vm.draft)
                .padding(.horizontal, 6)
                .textFieldStyle(.plain)
                .padding(8)
                .glassEffect()

            Button(role: .confirm) {
                Task {
                    await vm.getResponse()
                }
            } label: {
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 20)
                    .padding(.vertical, 2)
            }
            .foregroundStyle(vm.draft.isEmpty ? .gray : .blue)
            .disabled(vm.isResponding || vm.draft.isEmpty)
        }
        .padding(6)
    }
}

#Preview() {
    Typebar(vm: ViewModel())
}
