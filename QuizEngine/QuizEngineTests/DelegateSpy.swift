//
//  DelegateSpy.swift
//  QuizEngineTests
//
//  Created by Aaron Huánuco on 20/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import QuizEngine

class DelegateSpy: QuizDelegate {
    var questionsAsked: [String] = []
    var answerCompletions: [(String) -> Void] = []

    var completedQuizzes: [[(String,String)]] = []

    func answer(for question: String, completion: @escaping (String) -> Void) {
        questionsAsked.append(question)
        self.answerCompletions.append(completion)
    }

    func didCompleteQuiz(withAnswers answers: [(question: String, answer: String)]) {
        completedQuizzes.append(answers)
    }
}
