//
//  iOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Aaron Huánuco on 13/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
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
        let controller = makeController(question: singleAnswerQuestion)
        controller.loadViewIfNeeded()

        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
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
        let controller = makeController(question: multipleAnswerQuestion)
        controller.loadViewIfNeeded()

        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }

    // MARK: - Helpers
    func makeSUT(options: [Question<String>: [String]]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: options)
    }

    private func makeController(question: Question<String>) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
    }
}
