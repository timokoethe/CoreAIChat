//
//  ErrorView.swift
//  CoreAIChat
//
//  Created by Timo Köthe on 12.06.26.
//

import SwiftUI

struct ErrorView: View {
    let title: String
    let description: String?
    let icon: String
    
    init(title: String, description: String?, icon: String) {
        self.title = title
        self.description = description
        self.icon = icon
    }
    
    init(title: String, icon: String) {
        self.title = title
        self.description = nil
        self.icon = icon
    }
    
    var body: some View {
        if let description = description {
            ContentUnavailableView(title, systemImage: icon, description: Text(description))
        } else {
            ContentUnavailableView(title, systemImage: icon)
        }

    }
}

#Preview {
    ErrorView(title: "Example Title", description: "Example Description", icon: "nosign")
}
