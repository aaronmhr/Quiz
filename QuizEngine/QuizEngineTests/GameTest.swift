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
    let router = RouterSpy()
    var game: Game<String, String, RouterSpy>!

    func test_startGame_answerZeroOutOfTwoCorrectly_scoresZero() {
        game = startGame(questions: ["Q1","Q2"], router: router, correctAnswers: ["Q1":"A1", "Q2": "A2"])

        router.answerCallback("wrong")
        router.answerCallback("wrong")

        XCTAssertEqual(router.routedResults!.score, 0)
    }

    func test_startGame_answerOneOutOfTwoCorrectly_scoresOne() {
        game = startGame(questions: ["Q1","Q2"], router: router, correctAnswers: ["Q1":"A1", "Q2": "A2"])

        router.answerCallback("A1")
        router.answerCallback("wrong")

        XCTAssertEqual(router.routedResults!.score, 1)
    }

    func test_startGame_answerTwoOutOfTwoCorrectly_scoresTwo() {
        game = startGame(questions: ["Q1","Q2"], router: router, correctAnswers: ["Q1":"A1", "Q2": "A2"])

        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedResults!.score, 2)
    }
}