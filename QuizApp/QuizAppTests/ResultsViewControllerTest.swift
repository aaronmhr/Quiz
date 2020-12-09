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
        let sut = ResultsViewController(summary: "a summary")

        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.headerLabel.text, "a summary")
    }
}
