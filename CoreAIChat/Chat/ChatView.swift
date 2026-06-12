//
//  ChatView.swift
//  CoreAIChat
//
//  Created by Timo Köthe on 09.06.26.
//

import SwiftUI

struct ChatView: View {
    @Bindable var vm: ViewModel
    
    var body: some View {
        VStack() {
            ScrollView {
                ForEach(vm.messages) { message in
                    MessageBubble(message: message)
                }
                if vm.isResponding {
                    HStack {
                        ProgressView()
                        Spacer()
                    }
                }
            }
            .defaultScrollAnchor(.bottom)
            .padding(.horizontal, 5)
            
            Typebar(vm: vm)
        }
    }
}

#Preview {
    ChatView(vm: {
        let vm = ViewModel()
        vm.status = .ready
        vm.isResponding = true
        vm.draft = "Hello Gemma!"
        vm.messages = [
            Message(role: .user, text: "Hello!"),
            Message(role: .assistant, text: "How can I help you?"),
            Message(role: .user, text: "Hello again, this is a very long message from the user to show how mutliline alignment looks like!"),
            Message(role: .assistant, text: "That's cool! This is a long answer from the model to show how the multiline alignment looks from that side."),
        ]
        return vm
    }())
}
