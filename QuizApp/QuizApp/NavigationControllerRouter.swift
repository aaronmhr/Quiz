//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 13/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit
import QuizEngine

enum Question<T: Hashable>: Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)

    func hash(into hasher: inout Hasher) {
        switch self {
        case .singleAnswer(let value):
            return hasher.combine(value)
        default:
            fatalError()
        }
    }
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
        navigationController.pushViewController(viewController, animated: true)
    }

    func routeTo(result: Result<String, String>) {

    }
}
