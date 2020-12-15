//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 13/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    typealias Question = QuizEngine.Question<String>
    typealias Answer = Set<String>

    func questionViewController(for question: Question, answerCallback: @escaping (Answer) -> Void) -> UIViewController
    func resultsViewController(for result: Result<Question, Answer>) -> UIViewController
}
