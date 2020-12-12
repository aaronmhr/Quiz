//
//  GameTest.swift
//  QuizEngineTests
//
//  Created by Aaron Huánuco on 12/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
import QuizEngine

class GameTest: XCTestCase {
    func test_startGame_answerOneOutOfTwoCorrectly_scores1() {
        let router = RouterSpy()
        let game = startGame(questions: ["Q1","Q2"], router: router, correctAnswers: ["Q1":"A1", "Q2": "A2"])

        router.answerCallback("A1")
        router.answerCallback("wrong")

        XCTAssertEqual(router.routedResults!.score, 1)
    }
}
