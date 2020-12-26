//
//  MultipleTextSelectionCell.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 25/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import SwiftUI

struct MultipleTextSelectionCell: View {
    @Binding var option: MultipleSelectionOption

    var body: some View {
        Button(action: { option.select() }, label: {
            HStack {
                Rectangle()
                    .strokeBorder(option.isSelected ? Color.blue : .secondary, lineWidth: 2.5)
                    .overlay(
                        Rectangle()
                            .fill(option.isSelected ? Color.blue : .clear)
                            .frame(width: 25, height: 26)
                    )
                    .frame(width: 40, height: 40)

                Text(option.text)
                    .font(.title)
                    .foregroundColor(.secondary)

                Spacer()
            }.padding()

        })
    }
}

struct MultipleTextSelectionCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MultipleTextSelectionCell(
                option: .constant(.init(text: "A text", isSelected: false))
            ).previewLayout(.sizeThatFits)

            MultipleTextSelectionCell(
                option: .constant(.init(text: "A text", isSelected: true))
            ).previewLayout(.sizeThatFits)
        }
    }
}
