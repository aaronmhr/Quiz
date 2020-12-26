//
//  MultipleAnswerQuestion.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 25/12/20.
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

struct MultipleAnswerQuestion: View {
    let title: String
    let question: String
    @State  var store: MultipleSelectionStore

    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {

            HeaderView(title: title, subtitle: question)

            ForEach(store.options.indices) { i in
                MultipleTextSelectionCell(option: $store.options[i])
            }

            Spacer()

            RoundedButton(title: "Submit", isEnabled: store.canSubmit, action: store.submit)
                .padding()
        }
    }
}

struct MultipleAnswerQuestion_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MultipleAnswerQuestionTestView()

            MultipleAnswerQuestionTestView()
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
    }

    struct MultipleAnswerQuestionTestView: View {
        @State var selection = ["none"]

        var body: some View {
            VStack {
                MultipleAnswerQuestion(
                    title: "2 of 2",
                    question: "What's Caio's nationality?",
                    store: .init(options: [
                        "Portuguese",
                        "American",
                        "Greek",
                        "Canadian"
                    ], handler: { selection = $0 }
                ))

                Text("Last submition: " + selection.joined(separator: ", "))
            }
        }
    }
}
