//
//  iOSViewControllerTest.swift
//  QuizAppTests
//
//  Created by Aaron Huánuco on 13/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
@testable import QuizApp

class iOSViewControllerFactory {
    private let options: [Question<String>: [String]]

    init(options: [Question<String>: [String]]) {
        self.options = options
    }
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        guard let options = self.options[question] else {
            fatalError("Couldn't find options for question: \(question)")
        }
        switch question {
        case .singleAnswer(let questionString):
            return QuestionViewController(question: questionString, options: options, selection: answerCallback)
        default:
            return UIViewController()
        }
    }
}

class iOSViewControllerTest: XCTestCase {
    func test_questionViewController_singleAnswer_createsControllerWithQuestion() {
        let question = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        let controller = sut.questionViewController(for: question, answerCallback: { _ in }) as? QuestionViewController

        XCTAssertEqual(controller?.question, "Q1")
    }

    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        let question = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        let controller = sut.questionViewController(for: question, answerCallback: { _ in }) as? QuestionViewController

        XCTAssertEqual(controller?.options, options)
    }
}
