//
//  ChatMessage.swift
//  CoreChat
//
//  Created by Timo Köthe on 09.06.26.
//

import Foundation

struct ChatMessage: Identifiable {
    enum Role {
        case user
        case assistant
    }

    let id = UUID()
    let role: Role
    var text: String
}
