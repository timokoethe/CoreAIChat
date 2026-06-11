//
//  MessageBubble.swift
//  CoreAIChat
//
//  Created by Timo Köthe on 09.06.26.
//

import SwiftUI

struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.role == .user { Spacer(minLength: 40) }
            
            Text(message.text)
                .textSelection(.enabled)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(message.role == .user ? .blue : .pink, in: .rect(cornerRadius: 16))
                .foregroundStyle(.white)
            
            if message.role == .assistant { Spacer(minLength: 40) }
        }
    }
}

#Preview {
    MessageBubble(message: Message(role: .user, text: "text"))
}
