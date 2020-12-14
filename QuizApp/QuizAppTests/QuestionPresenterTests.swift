//
//  QuestionPresenterTests.swift
//  QuizAppTests
//
//  Created by Aaron Huánuco on 14/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
@testable import QuizApp

struct QuestionPresenter {
    let questions: [Question<String>]
    let question: Question<String>

    var title: String {
        "Question #1"
    }
}

class QuestionPresenterTests: XCTestCase {
    func test_title() {
        let question1 = Question.singleAnswer("A1")
        let sut = QuestionPresenter(questions: [question1], question: question1)
        XCTAssertEqual(sut.title, "Question #1")
    }
}
