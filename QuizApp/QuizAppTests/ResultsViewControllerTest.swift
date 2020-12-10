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
        let sut = ResultsViewController(summary: "a summary", answers: [])

        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.headerLabel.text, "a summary")
    }

    func test_viewDidLoad_withoutAnswers_doesNotRenderAnswers() {
        let sut = ResultsViewController(summary: "a summary", answers: [])

        _ = sut.view

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }

    func test_viewDidLoad_withOneAnswer_rendersAnswer() {
        let sut = ResultsViewController(summary: "a summary", answers: ["A1"])

        _ = sut.view

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
}
