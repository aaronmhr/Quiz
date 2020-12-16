//
//  Router.swift
//  QuizEngine
//
//  Created by Aaron Huánuco on 12/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public protocol QuizDelegate {
    associatedtype Answer
    associatedtype Question: Hashable

    func handle(question: Question, answerCallback: @escaping (Answer) -> Void)
    func handle(result: Result<Question, Answer>)
}

@available(*, deprecated)
public protocol Router {
    associatedtype Answer
    associatedtype Question: Hashable

    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Result<Question, Answer>)
}
