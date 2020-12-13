//
//  ResultsPresenterTests.swift
//  QuizAppTests
//
//  Created by Aaron Huánuco on 13/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
import QuizEngine
@testable import QuizApp

struct ResultsPresenter {
    let result: Result<Question<String>, [String]>

    init(result: Result<Question<String>, [String]>) {
        self.result = result
    }

    var summary: String {
        "You got 1/2 correct"
    }
}

class ResultsPresenterTests: XCTestCase {
    func test_summary_withTwoQuestionsAnsScoreOne_returnsSummary() {
        let answers = [Question.singleAnswer("Q1"): ["A1"], .multipleAnswer("Q2"): ["A2", "A3"]]
        let result = Result.make(answers: answers, score: 1)
        let sut = ResultsPresenter(result: result)
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
}