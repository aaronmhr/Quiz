//
//  QuestionPresenter.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 14/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import QuizEngine

struct QuestionPresenter {
    let questions: [Question<String>]
    let question: Question<String>

    var title: String {
        guard let index = questions.firstIndex(of: question) else { return ""
        }
        return "Question #\(index + 1)"
    }
}
