//
//  QuizDelegate.swift
//  QuizEngine
//
//  Created by Aaron Huánuco on 19/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public protocol QuizDelegate {
    associatedtype Answer
    associatedtype Question: Hashable

    func handle(question: Question, answerCallback: @escaping (Answer) -> Void)
    func handle(result: Result<Question, Answer>)
}