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
}
