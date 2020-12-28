//
//  NonEmptyOptions.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 28/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

struct NonEmptyOptions {
    let head: String
    let tail: [String]

    var all: [String] {
        [head] + tail
    }
}
