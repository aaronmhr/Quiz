//
//  RouterSpy.swift
//  QuizEngineTests
//
//  Created by Aaron Huánuco on 12/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import QuizEngine

class RouterSpy: Router {
    var routedQuestions: [String] = []
    var routedResult: Result<String, String>? = nil

    var answerCallback: (String) -> Void = { _ in }

    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }

    func routeTo(result: Result<String, String>) {
        routedResult = result
    }
}
