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
        return "Question #\(questions.firstIndex(of: question)! + 1)"
    }
}

class QuestionPresenterTests: XCTestCase {
    func test_title_forFirstQuestion_formatsTitleForIndex() {
        let question1 = Question.singleAnswer("Q1")
        let sut = QuestionPresenter(questions: [question1], question: question1)
        XCTAssertEqual(sut.title, "Question #1")
    }

    func test_title_forSecondQuestion_formatsTitleForIndex() {
        let q1 = Question.singleAnswer("Q1")
        let q2 = Question.multipleAnswer("Q2")
        
        let sut = QuestionPresenter(questions: [q1, q2], question: q2)
        XCTAssertEqual(sut.title, "Question #2")
    }
}
