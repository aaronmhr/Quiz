//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by Aaron Huánuco on 13/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
import QuizEngine
@testable import QuizApp

class NavigationControllerRouterTest: XCTestCase {

    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q1")

    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    lazy var sut = NavigationControllerRouter(navigationController, factory: factory)

    func test_routeQuestion_showsQuestionController() {
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        factory.stub(question: singleAnswerQuestion, with: vc1)
        factory.stub(question: multipleAnswerQuestion, with: vc2)

        sut.routeTo(question:singleAnswerQuestion, answerCallback: { _ in })
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers, [vc1, vc2])
    }

    func test_routeToQuestion_singleAnswer_answerCallback_progressesToNextQuestion() {
        var callbackWasFired = false
        sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in
            callbackWasFired = true
        })
        factory.answerCallbacks[singleAnswerQuestion]?(["anything"])

        XCTAssertTrue(callbackWasFired)
    }

    func test_routeToQuestion_singleAnswer_doesNotConfigureSubmittButton() {
        let viewController = UIViewController()
        factory.stub(question: singleAnswerQuestion, with: viewController)

        sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in })

        XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
    }

    func test_routeToQuestion_multipleAnswer_answerCallback_doesNotProgressToNextQuestion() {
        var callbackWasFired = false
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in
            callbackWasFired = true
        })
        factory.answerCallbacks[multipleAnswerQuestion]?(["anything"])

        XCTAssertFalse(callbackWasFired)
    }

    func test_routeToQuestion_multipleAnswer_answerCallback_configuresViewControllerWithSubmitButton() {
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })

        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
    }

    func test_routeToQuestion_multipleAnswerSubmitButton_isDisabledWhenZeroAnswersSelected() {
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)

        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)

        factory.answerCallbacks[multipleAnswerQuestion]?(["A1"])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)

        factory.answerCallbacks[multipleAnswerQuestion]?([])
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
    }

    func test_routeToQuestion_multipleAnswerSubmitButton_progressesToNextQuestion() {
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)

        var callbackWasFired = false
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in
            callbackWasFired = true
        })

        factory.answerCallbacks[multipleAnswerQuestion]!(["A1"])
        viewController.navigationItem.rightBarButtonItem?.simulateTap()

        XCTAssertTrue(callbackWasFired)
    }

    func test_routeToResult_showsResultController() {
        let vc1 = UIViewController()
        let result1 = Result.make(answers: [singleAnswerQuestion: ["A1"]], score: 10)

        let vc2 = UIViewController()
        let result2 = Result.make(answers: [singleAnswerQuestion: ["A2"]], score: 20)

        factory.stub(result: result1, with: vc1)
        factory.stub(result: result2, with: vc2)

        sut.routeTo(result: result1)
        sut.routeTo(result: result2)

        XCTAssertEqual(navigationController.viewControllers, [vc1, vc2])
    }

    // MARK: - Helpers

    class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }

    class ViewControllerFactoryStub: ViewControllerFactory {
        private var stubbedQuestions = [Question<String>: UIViewController]()
        private var stubbedResults = [Result<Question<String>, [String]>: UIViewController]()
        private(set) var answerCallbacks = [Question<String>: ([String]) -> Void]()

        func stub(question: Question<String>, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }

        func stub(result: Result<Question<String>, [String]>, with viewController: UIViewController) {
            stubbedResults[result] = viewController
        }

        func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
            answerCallbacks[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }

        func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
            stubbedResults[result] ?? UIViewController()
        }
    }
}

private extension UIBarButtonItem {
    func simulateTap() {
        target!.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}
