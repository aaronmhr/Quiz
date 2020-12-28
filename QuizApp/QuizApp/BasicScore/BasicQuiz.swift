//
//  BasicQuiz.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 28/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import QuizEngine

public struct BasicQuiz {
    public let questions: [Question<String>]
    public let options: [Question<String>: [String]]
    public let correctAnswers: [(Question<String>, [String])]

    init(questions: [Question<String>], options: [Question<String> : [String]], correctAnswers: [(Question<String>, [String])]) {
        self.questions = questions
        self.options = options
        self.correctAnswers = correctAnswers
    }
}
