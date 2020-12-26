//
//  iOSSwiftUIViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Aaron Huánuco on 25/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
import SwiftUI
import QuizEngine
@testable import QuizApp

class iOSSwiftUIViewControllerFactoryTest: XCTestCase {
    func test_questionViewController_singleAnswer_createsControllerWithTitle() throws {
        let presenter = QuestionPresenter(questions: questions, question: singleAnswerQuestion)
        let view = try XCTUnwrap(makeSingleAnswerQuestion())

        XCTAssertEqual(view.title, presenter.title)
    }

    func test_questionViewController_singleAnswer_createsControllerWithQuestion() throws {
        let view = try XCTUnwrap(makeSingleAnswerQuestion())

        XCTAssertEqual(view.question, "Q1")
    }

    func test_questionViewController_singleAnswer_createsControllerWithOptions() throws {
        let view = try XCTUnwrap(makeSingleAnswerQuestion())

        XCTAssertEqual(view.options, options[singleAnswerQuestion])
    }

    func test_questionViewController_singleAnswer_createsControllerWithAnswerCallback() throws {
        var answers = [[String]]()
        let view = try XCTUnwrap(makeSingleAnswerQuestion(answerCallback: { answers.append($0) }))

        XCTAssertEqual(answers, [])

        view.selection(view.options[0])
        XCTAssertEqual(answers, [[view.options[0]]])

        view.selection(view.options[1])
        XCTAssertEqual(answers, [[view.options[0]], [view.options[1]]])

    }

    func test_questionViewController_multipleAnswer_createsControllerWithTitle() throws {
        let presenter = QuestionPresenter(questions: questions, question: multipleAnswerQuestion)
        let view = try XCTUnwrap(makeMultipleAnswerQuestion())

        XCTAssertEqual(view.title, presenter.title)
    }

    func test_questionViewController_multipleAnswer_createsControllerWithQuestion() throws {
        let view = try XCTUnwrap(makeMultipleAnswerQuestion())

        XCTAssertEqual(view.question, "Q2")
    }

    func test_questionViewController_multipleAnswer_createsControllerWithOptions() throws {
        let view = try XCTUnwrap(makeMultipleAnswerQuestion())

        XCTAssertEqual(view.store.options.map(\.text), options[multipleAnswerQuestion])
    }

    func test_resultView_createsControllerWithTitle() throws {
        let (view, presenter) = try XCTUnwrap(makeResults())

        XCTAssertEqual(view.title, presenter.title)
    }

    func test_resultView_createsControllerWithSummary() throws {
        let (controller, presenter) = try XCTUnwrap(makeResults())

        XCTAssertEqual(controller.summary, presenter.summary)
    }

    func test_resultView_createsControllerWithPresentableAnswers() throws {
        let (view, presenter) = try XCTUnwrap(makeResults())

        XCTAssertEqual(view.answers, presenter.presentableAnswers)
    }

    // MARK: Helpers
    private var singleAnswerQuestion: Question<String> { .singleAnswer("Q1") }

    private var multipleAnswerQuestion: Question<String> { .multipleAnswer("Q2") }

    var questions: [Question<String>] {
        [singleAnswerQuestion, multipleAnswerQuestion]
    }

    private var options: [Question<String>: [String]] {
        [singleAnswerQuestion: ["A1", "A2", "A3"], multipleAnswerQuestion: ["A4", "A5", "A6"]]
    }

    private var correctAnswers: [(Question<String>, [String])] {
        [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A4", "A5"])]
    }

    private func makeSUT() -> iOSSwiftUIViewControllerFactory {
        return iOSSwiftUIViewControllerFactory(options: options, correctAnswers: correctAnswers)
    }

    private func makeSingleAnswerQuestion(
        answerCallback: @escaping ([String]) ->Void = { _ in }
    ) -> SingleAnswerQuestion? {
        let sut = makeSUT()
        let controller = sut.questionViewController(
            for: singleAnswerQuestion,
            answerCallback: answerCallback
        ) as? UIHostingController<SingleAnswerQuestion>
        return controller?.rootView
    }

    private func makeMultipleAnswerQuestion(
        answerCallback: @escaping ([String]) -> Void = { _ in }
    ) -> MultipleAnswerQuestion? {
        let sut = makeSUT()
        let controller = sut.questionViewController(
            for: multipleAnswerQuestion,
            answerCallback: answerCallback
        ) as? UIHostingController<MultipleAnswerQuestion>
        return controller?.rootView
    }

    private func makeResults() -> (view: ResultView, presenter: ResultsPresenter)? {
        let sut = makeSUT()
        let controller = sut.resultsViewController(for: correctAnswers) as? UIHostingController<ResultView>
        let presenter = ResultsPresenter(
            userAnswers: correctAnswers,
            correctAnswers: correctAnswers,
            scorer: BasicScore.score
        )
        return controller.map { ($0.rootView, presenter) }
    }
}
