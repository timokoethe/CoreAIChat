//
//  ChatMessage.swift
//  CoreAIChat
//
//  Created by Timo Köthe on 09.06.26.
//

import Foundation

struct Message: Identifiable {
    enum Role {
        case user
        case assistant
    }

    let id = UUID()
    let role: Role
    var text: String
}
