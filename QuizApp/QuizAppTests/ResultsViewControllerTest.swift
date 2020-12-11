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

    func test_viewDidLoad_withoutAnswers_doesNotRenderAnswers() {

    }
    func test_viewDidLoad_rendersAnswers() {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeDummyAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }

    // MARK: - Helpers
    private func makeSUT(summary: String = "", answers: [String] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        sut.loadViewIfNeeded()
        return sut
    }

    func makeDummyAnswer() -> String {
        "an answer"
    }

}
