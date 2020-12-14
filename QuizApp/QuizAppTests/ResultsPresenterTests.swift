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

class ResultsPresenterTests: XCTestCase {
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")

    func test_summary_withTwoQuestionsAndScoreOne_returnsSummary() {
        let answers = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A2", "A3"]]
        let orderedQuestions = [singleAnswerQuestion, multipleAnswerQuestion]
        let result = Result.make(answers: answers, score: 1)

        let sut = ResultsPresenter(result: result, correctAnswers: [:], questions: orderedQuestions)

        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }

    func test_presentableAnswers_withoutQuestions_isEmpty() {
        let answers = [Question<String>: [String]]()
        let result = Result.make(answers: answers, score: 0)

        let sut = ResultsPresenter(result: result, correctAnswers: [:], questions: [])

        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }

    func test_presentableAnswers_withWrongOneSingleAnswer_mapsAnswer() {
        let answers = [singleAnswerQuestion: ["A2"]]
        let correctAnswers = [singleAnswerQuestion: ["A1"]]
        let orderedQuestions = [singleAnswerQuestion]
        let result = Result.make(answers: answers, score: 0)

        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers, questions: orderedQuestions)

        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A1")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer, "A2")
    }

    func test_presentableAnswers_withWrongMultipleAnswer_mapsAnswer() {
        let answers = [multipleAnswerQuestion: ["A1", "A3"]]
        let correctAnswers = [multipleAnswerQuestion: ["A2", "A4"]]
        let orderedQuestions = [multipleAnswerQuestion]
        let result = Result.make(answers: answers, score: 0)

        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers, questions: orderedQuestions)

        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A2, A4")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer, "A1, A3")
    }

    func test_presentableAnswers_withTwoQuestions_mapsOrderedAnswer() {
        let answers: [Question<String>: [String]] = [
            .multipleAnswer("Q1"): ["A1"],
            .singleAnswer("Q2"): ["A2"],
            .multipleAnswer("Q3"): ["A3", "A4"],
        ]
        let correctAnswers: [Question<String>: [String]] =  [
            .multipleAnswer("Q1"): ["A1"],
            .singleAnswer("Q2"): ["A2"],
            .multipleAnswer("Q3"): ["A3", "A4"]
        ]
        let orderedQuestions: [Question<String>] = [
            .multipleAnswer("Q1"),
            .singleAnswer("Q2"),
            .multipleAnswer("Q3"),
        ]
        let result = Result.make(answers: answers, score: 0)

        let sut = ResultsPresenter(
            result: result,
            correctAnswers: correctAnswers,
            questions: orderedQuestions
        )

        XCTAssertEqual(sut.presentableAnswers.count, 3)
        XCTAssertEqual(sut.presentableAnswers[0].question, "Q1")
        XCTAssertEqual(sut.presentableAnswers[0].answer, "A1")
        XCTAssertNil(sut.presentableAnswers[0].wrongAnswer)

        XCTAssertEqual(sut.presentableAnswers[1].question, "Q2")
        XCTAssertEqual(sut.presentableAnswers[1].answer, "A2")
        XCTAssertNil(sut.presentableAnswers[1].wrongAnswer)

        XCTAssertEqual(sut.presentableAnswers[2].question, "Q3")
        XCTAssertEqual(sut.presentableAnswers[2].answer, "A3, A4")
        XCTAssertNil(sut.presentableAnswers[2].wrongAnswer)
    }
}
