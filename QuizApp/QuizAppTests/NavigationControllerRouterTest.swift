//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by Aaron Huánuco on 13/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
import QuizEngine

import UIKit

protocol ViewControllerFactory {
    func questionViewController(for question: String, answerCallback: (String) -> Void) -> UIViewController
}

class NavigationControllerRouter: Router {
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory

    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        let viewController = factory.questionViewController(for: question, answerCallback: answerCallback)
        navigationController.pushViewController(viewController, animated: false)
    }

    func routeTo(result: Result<String, String>) {

    }
}


class NavigationControllerRouterTest: XCTestCase {
    func test_routeToQuestion_presentsQuestionController() {
        let navigationController = UINavigationController()
        let factory = ViewControllerFactoryStub()
        let viewController = UIViewController()
        factory.stub(question: "Q1", with: viewController)
        let sut = NavigationControllerRouter(navigationController, factory: factory)

        sut.routeTo(question: "Q1", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.first, viewController)
    }

    func test_routeToSecondQuestion_presentsQuestionController() {
        let navigationController = UINavigationController()
        let factory = ViewControllerFactoryStub()
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        factory.stub(question: "Q1", with: vc1)
        factory.stub(question: "Q2", with: vc2)
        let sut = NavigationControllerRouter(navigationController, factory: factory)

        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers, [vc1, vc2])
    }

    class ViewControllerFactoryStub: ViewControllerFactory {
        private var stubbedQuestions = [String: UIViewController]()

        func stub(question: String, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }

        func questionViewController(for question: String, answerCallback: (String) -> Void) -> UIViewController {
            stubbedQuestions[question]!
        }
    }
}
