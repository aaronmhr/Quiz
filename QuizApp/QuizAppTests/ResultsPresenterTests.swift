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
    let correctAnswers: [Question<String>: [String]]

    var summary: String {
        "You got \(result.score)/\(result.answers.count) correct"
    }

    var presentableAnswers: [PresentableAnswer] {
        result.answers.map { question, userAnswer in

            let correctAnswer = correctAnswers[question]!
            let wrongAnswer = correctAnswer == userAnswer ? nil : userAnswer.joined(separator: ", ")
            switch question {
            case .singleAnswer(let value), .multipleAnswer(let value):
                return PresentableAnswer(
                    question: value,
                    answer: correctAnswer.joined(separator: ", "),
                    wrongAnswer: wrongAnswer
                )
            }
        }
    }
}

class ResultsPresenterTests: XCTestCase {
    func test_summary_withTwoQuestionsAnsScoreOne_returnsSummary() {
        let answers = [Question.singleAnswer("Q1"): ["A1"], .multipleAnswer("Q2"): ["A2", "A3"]]
        let result = Result.make(answers: answers, score: 1)
        let sut = ResultsPresenter(result: result, correctAnswers: [:])
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }

    func test_presentableAnswers_withoutQuestions_isEmpty() {
        let answers = [Question<String>: [String]]()
        let result = Result.make(answers: answers, score: 0)

        let sut = ResultsPresenter(result: result, correctAnswers: [:])
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }

    func test_presentableAnswers_withWrongOneSingleAnswer_mapsAnswer() {
        let answers = [Question.singleAnswer("Q1"): ["A1"]]
        let correctAnswers = [Question.singleAnswer("Q1"): ["A2"]]
        let result = Result.make(answers: answers, score: 0)

        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer, "A1")
    }

    func test_presentableAnswers_withWrongMultipleAnswer_mapsAnswer() {
        let answers = [Question.multipleAnswer("Q1"): ["A1", "A3"]]
        let correctAnswers = [Question.multipleAnswer("Q1"): ["A2", "A4"]]
        let result = Result.make(answers: answers, score: 0)

        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A2, A4")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer, "A1, A3")
    }

    func test_presentableAnswers_withRightSingleAnswer_mapsAnswer() {
        let answers = [Question.singleAnswer("Q1"): ["A1"]]
        let correctAnswers = [Question.singleAnswer("Q1"): ["A1"]]
        let result = Result.make(answers: answers, score: 0)

        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A1")
        XCTAssertNil(sut.presentableAnswers.first?.wrongAnswer)
    }

    func test_presentableAnswers_withRightMultipleAnswer_mapsAnswer() {
        let answers = [Question.multipleAnswer("Q1"): ["A1", "A3"]]
        let correctAnswers = [Question.multipleAnswer("Q1"): ["A1", "A3"]]
        let result = Result.make(answers: answers, score: 0)

        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A1, A3")
        XCTAssertNil(sut.presentableAnswers.first?.wrongAnswer)
    }
}
