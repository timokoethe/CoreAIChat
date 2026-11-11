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
    let retry: (() -> Void)?
    
    init(
        title: String,
        description: String? = nil,
        icon: String,
        retry: (() -> Void)? = nil
    ) {
        self.title = title
        self.description = description
        self.icon = icon
        self.retry = retry
    }
    
    var body: some View {
        ContentUnavailableView {
            Label(title, systemImage: icon)
        } description: {
            if let description {
                Text(description)
            }
        } actions: {
            if let retry {
                Button("Try Again", action: retry)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    ErrorView(
        title: "Example Title",
        description: "Example Description",
        icon: "nosign",
        retry: {}
    )
}
