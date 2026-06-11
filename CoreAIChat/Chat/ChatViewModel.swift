//
//  ChatViewModel.swift
//  CoreAIChat
//
//  Created by Timo Köthe on 09.06.26.
//

import FoundationModels
import Observation
import Foundation

@MainActor
@Observable
final class ChatViewModel {
    var messages: [Message] = []
    var input: String = ""
    var isResponding = false
}
