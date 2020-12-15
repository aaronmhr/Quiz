//
//  Question.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 13/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public enum Question<T: Hashable>: Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)

    public func hash(into hasher: inout Hasher) {
        switch self {
        case .singleAnswer(let value):
            return hasher.combine(value)
        case .multipleAnswer(let value):
            return hasher.combine(value)
        }
    }
}
