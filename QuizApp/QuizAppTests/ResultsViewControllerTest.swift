//
//  ResultsViewControllerTest.swift
//  QuizAppTests
//
//  Created by Aaron Huánuco on 9/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizApp

class ResultsViewControllerTest: XCTestCase {
    func test_viewDidLoad_renderSummary() {
        XCTAssertEqual(makeSUT(summary: "a summary").headerLabel.text, "a summary")
    }

    func test_viewDidLoad_rendersAnswers() {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeAnswer(isCorrect: true)]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(answers: [makeAnswer(isCorrect: false)]).tableView.numberOfRows(inSection: 0), 1)
    }

    func test_viewDidLoad_withCorrectAnswer_configuresCell() throws {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1", answer: "A1", isCorrect: true)])

        let cell = try XCTUnwrap(sut.tableView.cell(at: 0) as? CorrectAnswerCell)

        XCTAssertEqual(cell.questionLabel.text, "Q1")
        XCTAssertEqual(cell.answerLabel.text, "A1")
    }

    func test_viewDidLoad_withWrongAnswer_configuresCell() throws {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "wrong", isCorrect: false)])

        let cell = try XCTUnwrap(sut.tableView.cell(at: 0) as? WrongAnswerCell)

        XCTAssertEqual(cell.questionLabel.text, "Q1")
        XCTAssertEqual(cell.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell.wrongAnswerLabel.text, "wrong")
    }

    // MARK: - Helpers
    private func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        sut.loadViewIfNeeded()
        return sut
    }

    func makeAnswer(question: String = "",
                    answer: String = "",
                    wrongAnswer: String? = nil,
                    isCorrect: Bool) -> PresentableAnswer {
        PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer, isCorrect: isCorrect)
    }
}
