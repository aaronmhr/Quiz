//
//  ScoreTest.swift
//  QuizEngineTests
//
//  Created by Aaron Huánuco on 20/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Foundation
import XCTest

class ScoreTest: XCTestCase {
    func test_noAnswers_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: [], comparingTo: []), 0)
    }

    func test_oneWrongAnswer_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: ["wrong"], comparingTo: ["correct"]), 0)
    }
    private class BasicScore {
        static func score(for: [Any], comparingTo: [Any] = []) -> Int {
            return 0
        }
    }
}
