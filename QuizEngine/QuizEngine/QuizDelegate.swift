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

    func answer(for question: Question, completion: @escaping (Answer) -> Void)

    func didCompleteQuiz(withAnswers: [(question: Question, answer: Answer)])
}
