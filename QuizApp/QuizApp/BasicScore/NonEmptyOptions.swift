//
//  NonEmptyOptions.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 28/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public struct NonEmptyOptions {
    public let head: String
    public let tail: [String]

    public init(head: String, tail: [String]) {
        self.head = head
        self.tail = tail
    }

    public var all: [String] {
        [head] + tail
    }
}
