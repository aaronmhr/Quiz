//
//  Game.swift
//  QuizEngine
//
//  Created by Aaron Huánuco on 12/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Foundation

public class Game<Question, Answer, R: Router> where R.Answer == Answer, R.Question == Question {
    let flow: Flow<Question, Answer, R>

    init(flow: Flow<Question, Answer, R>) {
        self.flow = flow
    }
}

public func startGame<Question, Answer, R: Router>(questions: [Question], router: R, correctAnswers: [Question: Answer]) -> Game<Question, Answer, R> where R.Answer == Answer, R.Question == Question {
    let flow = Flow(questions: questions, router: router, scoring: { _ in 1 })
    flow.start()
    return Game(flow: flow)
}
