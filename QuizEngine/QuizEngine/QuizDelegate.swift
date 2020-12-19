//
//  QuizDelegate.swift
//  QuizEngine
//
//  Created by Aaron Huánuco on 19/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public protocol QuizDelegate {
    associatedtype Question: Hashable
    associatedtype Answer

//    func answer(for question: Question, completion: @escaping (Answer) -> Void)

    func answer(for question: Question, completion: @escaping (Answer) -> Void)
    func didCompleteQuiz(withAnswers: [(question: Question, answer: Answer)])

    @available(*, deprecated, message: "use didCompleteQuiz(withAnswers:) instead")
    func handle(result: Result<Question, Answer>)
}

public extension QuizDelegate {
    func didCompleteQuiz(withAnswers: [(question: Question, answer: Answer)]) {}
}
