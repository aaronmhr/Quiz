//
//  MultipleSelectionStore.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 25/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

struct MultipleSelectionStore {
    var options: [MultipleSelectionOption]
    private let handler: ([String]) -> Void

    init(options: [String], handler: @escaping ([String]) -> Void) {
        self.options = options.map { MultipleSelectionOption(text: $0) }
        self.handler = handler
    }

    var canSubmit: Bool {
        !options.filter(\.isSelected).isEmpty
    }

    func submit() {
        guard canSubmit else { return }
        handler(options.filter(\.isSelected).map(\.text))
    }
}

struct MultipleSelectionOption {
    let text: String
    var isSelected = false

    mutating func select() {
        isSelected.toggle()
    }
}
