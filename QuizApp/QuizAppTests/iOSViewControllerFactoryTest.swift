//
//  iOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Aaron Huánuco on 13/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
import QuizEngine
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    typealias Question = QuizEngine.Question<String>
    typealias Answers = Set<String>

    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    let options = ["A1", "A2"]

    func test_questionViewController_singleAnswer_createsControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: singleAnswerQuestion)

        XCTAssertEqual(makeController(question: singleAnswerQuestion).title, presenter.title)
    }

    func test_questionViewController_singleAnswer_createsControllerWithQuestion() {
        XCTAssertEqual(makeController(question: singleAnswerQuestion).question, "Q1")
    }

    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeController(question: singleAnswerQuestion).options, options)
    }

    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {
        XCTAssertFalse(makeController(question: singleAnswerQuestion).allowsMultipleSelection)
    }

    func test_questionViewController_multipleAnswer_createsControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)

        XCTAssertEqual(makeController(question: multipleAnswerQuestion).title, presenter.title)
    }

    func test_questionViewController_multipleAnswer_createsControllerWithQuestion() {
        XCTAssertEqual(makeController(question: multipleAnswerQuestion).question, "Q2")
    }

    func test_questionViewController_multipleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeController(question: multipleAnswerQuestion).options, options)
    }

    func test_questionViewController_multipleAnswer_createsControllerWithMultipleSelection() {
        XCTAssertTrue(makeController(question: multipleAnswerQuestion).allowsMultipleSelection)
    }

    func test_resultsViewController_createsControllerWithTitle() {
        let (controller, presenter) = makeResults()

        XCTAssertEqual(controller.title, presenter.title)
    }

    func test_resultsViewController_createsControllerWithSummary() {
        let (controller, presenter) = makeResults()
        
        XCTAssertEqual(controller.summary, presenter.summary)
    }

    func test_resultsViewController_createsControllerWithAnswers() {
        let (controller, presenter) = makeResults()

        XCTAssertEqual(controller.answers.count, presenter.presentableAnswers.count)
    }

    // MARK: - Helpers
    func makeSUT(options: [Question: [String]] = [:], correctAnswers: [Question: Answers] = [:]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: options, correctAnswers: correctAnswers)
    }

    private func makeController(question: Question) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
    }

    private func makeResults() -> (controller: ResultsViewController, presenter: ResultsPresenter) {
        let userAnswers = [singleAnswerQuestion: Set(["A1"]), multipleAnswerQuestion: Set(["A1", "A2"])]
        let correctAnswers = [singleAnswerQuestion: Set(["A1"]), multipleAnswerQuestion: Set(["A1", "A2"])]
        let orderedOptions = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]]
        let questions = [singleAnswerQuestion, multipleAnswerQuestion]
        let result = QuizEngine.Result.make(answers: userAnswers, score: 2)

        let presenter = ResultsPresenter(result: result, questions: questions, options: orderedOptions, correctAnswers: correctAnswers)
        let sut = makeSUT(correctAnswers: correctAnswers)
        let controller = sut.resultsViewController(for: result) as! ResultsViewController
        return (controller, presenter)
    }
}
