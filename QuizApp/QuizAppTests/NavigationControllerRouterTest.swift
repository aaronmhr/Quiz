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

class NavigationControllerRouter: Router {
    private let navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        navigationController.pushViewController(UIViewController(), animated: false)
    }

    func routeTo(result: Result<String, String>) {

    }
}


class NavigationControllerRouterTest: XCTestCase {
    func test_routeToQuestion_presentsQuestionController() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController)

        sut.routeTo(question: "Q1", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }

    func test_routeToQuestionTwice_presentsQuestionController() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController)

        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
    }
}
