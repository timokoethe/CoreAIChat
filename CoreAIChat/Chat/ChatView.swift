//
//  ChatView.swift
//  CoreAIChat
//
//  Created by Timo Köthe on 09.06.26.
//

import SwiftUI

struct ChatView: View {
    @State private var vm = ChatViewModel()
    
    var body: some View {
        VStack() {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(vm.messages) { message in
                        MessageBubble(message: message)
                    }
                }
                .padding()
            }
            .defaultScrollAnchor(.bottom)
            
            HStack() {
                TextField("Message…", text: $vm.input, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                
                Button("Send") {
                }
                .disabled(vm.isResponding || vm.input.isEmpty)
            }
            .padding()
        }
    }
}

#Preview {
    ChatView()
}
