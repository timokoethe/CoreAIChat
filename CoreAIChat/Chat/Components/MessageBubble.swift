//
//  MessageBubble.swift
//  CoreAIChat
//
//  Created by Timo Köthe on 09.06.26.
//

import SwiftUI

struct MessageBubble: View {
    let message: Message

    private var isUser: Bool {
        message.role == .user
    }
    
    var body: some View {
        HStack {
            if isUser { Spacer(minLength: 48) }
            
            Text(message.text)
                .textSelection(.enabled)
                .padding(.horizontal, 13)
                .padding(.vertical, 9)
                .foregroundStyle(isUser ? .white : .primary)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(isUser ? Color.accentColor : Color.secondary.opacity(0.12))
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .stroke(.primary.opacity(isUser ? 0 : 0.08))
                }
            
            if !isUser { Spacer(minLength: 48) }
        }
    }
}

#Preview {
    MessageBubble(message: Message(role: .user, text: "text"))
}
