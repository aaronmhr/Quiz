//
//  NonEmptyOptions.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 28/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public struct NonEmptyOptions {
    private let head: String
    private let tail: [String]

    public init(_ head: String, _ tail: String...) {
        self.head = head
        self.tail = tail
    }

    public init(_ head: String, _ tail: [String]) {
        self.head = head
        self.tail = tail
    }

    public var all: [String] {
        [head] + tail
    }
}
