//
//  Quiz.swift
//  QuizEngine
//
//  Created by Aaron Huánuco on 19/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public final class Quiz {
    private let flow: Any

    private init(flow: Any) {
        self.flow = flow
    }

    public static func start<Question, Answer: Equatable, Delegate: QuizDelegate >(questions: [Question], delegate: Delegate, correctAnswers: [Question: Answer]) -> Quiz where Delegate.Answer == Answer, Delegate.Question == Question {
        let flow = Flow(questions: questions, delegate: delegate) {
            scoring($0, correctAnswers: correctAnswers)
        }
        flow.start()
        return Quiz(flow: flow)
    }
}
