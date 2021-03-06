//
//  BasicScore.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 20/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

final class BasicScore {
    static func score<T: Equatable>(for answers: [T], comparingTo correctAnswers: [T] = []) -> Int {
        return zip(answers, correctAnswers).reduce(0) { score, tuple in
            return score + (tuple.0 == tuple.1 ? 1 : 0)
        }
    }
}
