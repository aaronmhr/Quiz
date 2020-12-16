//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Aaron Huánuco on 15/09/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    
    private let delegate = RouterSpy()
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        makeSUT(questions: []).start()
        
        XCTAssertTrue(delegate.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestions_routesToCorrectQuestion() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertEqual(delegate.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestions_routesToCorrectQuestion_2() {
        makeSUT(questions: ["Q2"]).start()
        
        XCTAssertEqual(delegate.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        makeSUT(questions: ["Q1", "Q2"]).start()
        
        XCTAssertEqual(delegate.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(delegate.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routesToSecondAndThirdQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(delegate.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotRouteToQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        
        delegate.answerCallback("A1")
        
        XCTAssertEqual(delegate.routedQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestions_routesToResult() {
        makeSUT(questions: []).start()
        
        XCTAssertEqual(delegate.routedResults!.answers, [:])
    }
    
    func test_start_withOneQuestion_doesNotRouteToResult() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertNil(delegate.routedResults)
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestion_doesNotRouteToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        delegate.answerCallback("A1")
        
        XCTAssertNil(delegate.routedResults)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestion_routesToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(delegate.routedResults?.answers, ["Q1" : "A1", "Q2": "A2"])
    }

    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestion_scores() {
        let sut = makeSUT(questions: ["Q1", "Q2"]) { _ in 10}
        sut.start()

        delegate.answerCallback("A1")
        delegate.answerCallback("A2")

        XCTAssertEqual(delegate.routedResults?.score, 10)
    }

    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestion_scoresWithRightAnswers() {
        var receivedAnswers = [String: String]()
        let sut = makeSUT(questions: ["Q1", "Q2"]) { answers in
            receivedAnswers = answers
            return 0
        }
        sut.start()

        delegate.answerCallback("A1")
        delegate.answerCallback("A2")

        XCTAssertEqual(receivedAnswers, ["Q1" : "A1", "Q2": "A2"])
    }
    
    // MARK: Helpers
    
    private func makeSUT(questions: [String],
                 scoring: @escaping ([String: String]) -> Int = { _ in 0 }) -> Flow<String, String, RouterSpy> {
        return Flow(questions: questions, router: delegate, scoring: scoring)
    }

    private class RouterSpy: Router {
        var routedQuestions: [String] = []
        var routedResults: QuizEngine.Result<String, String>? = nil
        var answerCallback: (String) -> Void = { _ in }

        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }

        func routeTo(result: Result<String, String>) {
            routedResults =  result
        }
    }
}
