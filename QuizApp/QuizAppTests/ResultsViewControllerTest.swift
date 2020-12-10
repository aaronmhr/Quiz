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
        let sut = makeSUT(summary: "a summary", answers: [])

        XCTAssertEqual(sut.headerLabel.text, "a summary")
    }

    func test_viewDidLoad_withoutAnswers_doesNotRenderAnswers() {
        let sut = makeSUT(summary: "a summary", answers: [])

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }

    func test_viewDidLoad_withOneAnswer_rendersAnswer() {
        let sut = makeSUT(summary: "a summary", answers: ["A1"])

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }

    // MARK: - Helpers
    private func makeSUT(summary: String = "", answers: [String] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        sut.loadViewIfNeeded()
        return sut
    }
}
