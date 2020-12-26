//
//  RoundedButton.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 26/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import SwiftUI

struct RoundedButton: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void

    init(title: String, isEnabled: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.isEnabled = isEnabled
        self.action = action
    }

    var body: some View {
        Button(action: action, label: {
            HStack {
                Spacer()
                Text(title)
                    .foregroundColor(Color.white)
                    .padding()
                Spacer()
            }.background(Color.blue)
            .cornerRadius(25)
        })
        .buttonStyle(PlainButtonStyle())
        .disabled(!isEnabled)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RoundedButton(title: "Some button", isEnabled: false, action: { })
                .previewLayout(.sizeThatFits)
            RoundedButton(title: "Some button", isEnabled: true, action: { })
                .previewLayout(.sizeThatFits)

            RoundedButton(title: "Some button", isEnabled: false, action: { })
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
            RoundedButton(title: "Some button", isEnabled: true, action: { })
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
