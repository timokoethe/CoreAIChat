//
//  ChatMessage.swift
//  CoreAIChat
//
//  Created by Timo Köthe on 09.06.26.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let role: Role
    var text: String
    
    enum Role {
        case user
        case assistant
    }
}
