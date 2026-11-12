//
//  MessageBubble.swift
//  CoreAIChat
//
//  Created by Timo Köthe on 09.06.26.
//

import SwiftUI

struct MessageBubble: View {
    @Environment(\.colorScheme) private var colorScheme

    let message: Message

    private var isUser: Bool {
        message.role == .user
    }

    private var bubbleColor: Color {
        if colorScheme == .dark {
            Color(white: isUser ? 0.26 : 0.16)
        } else {
            Color(white: isUser ? 0.90 : 0.98)
        }
    }
    
    var body: some View {
        HStack {
            if isUser { Spacer(minLength: 48) }
            
            Text(message.text)
                .textSelection(.enabled)
                .padding(.horizontal, 13)
                .padding(.vertical, 9)
                .foregroundStyle(.primary)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(bubbleColor)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .stroke(.primary.opacity(0.08))
                }
            
            if !isUser { Spacer(minLength: 48) }
        }
    }
}

#Preview {
    MessageBubble(message: Message(role: .user, text: "text"))
}
