//
//  ResultsPresenter.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 14/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import QuizEngine

struct ResultsPresenter {
    typealias Question = QuizEngine.Question<String>
    typealias Answers = Set<String>
    typealias OrderedAnswers = [String]

    private let result: Result<Question, Answers>
    private let questions: [Question]
    private let options: [Question: OrderedAnswers]
    private let correctAnswers: [Question: Answers]

    init(result: Result<Question, Answers>, questions: [Question], options: [Question: OrderedAnswers], correctAnswers: [Question : Answers]) {
        self.result = result
        self.questions = questions
        self.options = options
        self.correctAnswers = correctAnswers
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

    private func presentableAnswer(_ question: Question, _ correctAnswer: Answers, _ userAnswer: Answers) -> PresentableAnswer {
        switch question {
        case .singleAnswer(let value), .multipleAnswer(let value):
            return PresentableAnswer(
                question: value,
                answer: formattedAnswer(
                    ordered(correctAnswer, for: question)),
                wrongAnswer: formattedWrongAnswer(
                    ordered(userAnswer, for: question),
                    ordered(correctAnswer, for: question)
                )
            )
        }
    }

    private func ordered(_ answers: Answers, for question: Question) -> OrderedAnswers {
        return options[question]?.filter { answers.contains($0) } ?? []
    }

    private func formattedAnswer(_ answers: [String]) -> String {
        answers.joined(separator: ", ")
    }

    private func formattedWrongAnswer(_ userAnswer: [String], _ correctAnswer: [String]) -> String? {
        correctAnswer == userAnswer ? nil : userAnswer.joined(separator: ", ")
    }
}
