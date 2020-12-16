//
//  ResultsPresenter.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 14/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import QuizEngine

struct ResultsPresenter {
    private let result: Result<Question<String>, [String]>
    private let questions: [Question<String>]
    private let correctAnswers: [Question<String>: [String]]

    init(result: Result<Question<String>, [String]>, questions: [Question<String>], correctAnswers: [Question<String> : [String]]) {
        self.result = result
        self.questions = questions
        self.correctAnswers = correctAnswers
    }

    var title: String {
        "Result"
    }

    var summary: String {
        "You got \(result.score)/\(result.answers.count) correct"
    }

    var presentableAnswers: [PresentableAnswer] {
        questions.map { question in
            guard let userAnswer = result.answers[question],
                let correctAnswer = correctAnswers[question] else {
                fatalError("Couldn't find correct answer for question: \(question)")
            }
            return presentableAnswer(question, correctAnswer, userAnswer)
        }
    }

    private func presentableAnswer(_ question: Question<String>, _ correctAnswer: [String], _ userAnswer: [String]) -> PresentableAnswer {
        switch question {
        case .singleAnswer(let value), .multipleAnswer(let value):
            return PresentableAnswer(
                question: value,
                answer: formattedAnswer(correctAnswer),
                wrongAnswer: formttedWrongAnswer(userAnswer, correctAnswer)
            )
        }
    }

    private func formattedAnswer(_ answers: [String]) -> String {
        answers.joined(separator: ", ")
    }

    private func formttedWrongAnswer(_ userAnswer: [String], _ correctAnswer: [String]) -> String? {
        correctAnswer == userAnswer ? nil : userAnswer.joined(separator: ", ")
    }
}
