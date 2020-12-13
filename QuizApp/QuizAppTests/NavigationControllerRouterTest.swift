//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by Aaron Huánuco on 13/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
@testable import QuizApp

class NavigationControllerRouterTest: XCTestCase {
    let navigationController = UINavigationController()
    let factory = ViewControllerFactoryStub()

    func test_routeQuestion_showsQuestionController() {
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        factory.stub(question: "Q1", with: vc1)
        factory.stub(question: "Q2", with: vc2)
        let sut = NavigationControllerRouter(navigationController, factory: factory)

        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers, [vc1, vc2])
    }

    func test_routeToSecondQuestion_presentsQuestionWithRightCallback() {
        let vc1 = UIViewController()
        factory.stub(question: "Q1", with: vc1)
        let sut = NavigationControllerRouter(navigationController, factory: factory)

        var callbackWasFired = false
        sut.routeTo(question: "Q1", answerCallback: { _ in
            callbackWasFired = true
        })
        factory.answerCallbacks["Q1"]?("anything")

        XCTAssertTrue(callbackWasFired)
    }

    class ViewControllerFactoryStub: ViewControllerFactory {
        private var stubbedQuestions = [String: UIViewController]()
        private(set) var answerCallbacks = [String: (String) -> Void]()

        func stub(question: String, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }

        func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController {
            answerCallbacks[question] = answerCallback
            return stubbedQuestions[question]!
        }
    }
}
