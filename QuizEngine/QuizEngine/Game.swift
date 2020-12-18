//
//  Game.swift
//  QuizEngine
//
//  Created by Aaron Huánuco on 12/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Foundation

public class Game<Question, Answer, R: Router> {
    let flow: Any

    init(flow: Any) {
        self.flow = flow
    }
}

@available(*, deprecated)
public func startGame<Question, Answer: Equatable, R: Router>(questions: [Question], router: R, correctAnswers: [Question: Answer]) -> Game<Question, Answer, R> where R.Answer == Answer, R.Question == Question {
    let flow = Flow(questions: questions, delegate: QuizDelegateToRouterAdapter(router)) {
        scoring($0, correctAnswers: correctAnswers)
    }
    flow.start()
    return Game(flow: flow)
}

@available(*, deprecated)
private class QuizDelegateToRouterAdapter<R: Router>: QuizDelegate {
    let router: R

    init(_ router: R) {
        self.router = router
    }

    func handle(question: R.Question, answerCallback: @escaping (R.Answer) -> Void) {
        router.routeTo(question: question, answerCallback: answerCallback)
    }

    func handle(result: Result<R.Question, R.Answer>) {
        router.routeTo(result: result)
    }
}

private func scoring<Question: Hashable, Answer: Equatable>(_ answers: [Question: Answer], correctAnswers: [Question: Answer]) -> Int {
    return answers.reduce(0) { (score, tuple) in
        return score + (correctAnswers[tuple.key] == tuple.value ? 1 : 0)
    }
}
