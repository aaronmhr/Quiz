//
//  BasicQuizBuilder.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 28/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import QuizEngine

public struct BasicQuizBuilder {
    private var questions: [Question<String>] = []
    private var options: [Question<String>: [String]] = [:]
    private var correctAnswers: [(Question<String>, [String])] = []

    public enum AddingError: Error, Equatable {
        case duplicateOptions([String])
        case missingAnswerInOptions(answer: [String], options: [String])
        case duplicateQuestion(Question<String>)
    }

    public init(singleAnswerQuestion: String, options: NonEmptyOptions, answer: String) throws {
        try add(singleAnswerQuestion: singleAnswerQuestion, options: options, answer: answer)
    }

    private init(questions: [Question<String>], options: [Question<String> : [String]], correctAnswers: [(Question<String>, [String])]) {
        self.questions = questions
        self.options = options
        self.correctAnswers = correctAnswers
    }

    public mutating func add(singleAnswerQuestion: String, options: NonEmptyOptions, answer: String) throws {
        self = try adding(singleAnswerQuestion: singleAnswerQuestion, options: options, answer: answer)
    }

    public func adding(singleAnswerQuestion: String, options: NonEmptyOptions, answer: String) throws -> BasicQuizBuilder {
        let question = Question.singleAnswer(singleAnswerQuestion)

        guard !questions.contains(question) else {
            throw AddingError.duplicateQuestion(question)
        }

        let allOptions = options.all

        guard allOptions.contains(answer) else {
            throw AddingError.missingAnswerInOptions(answer: [answer], options: allOptions)
        }

        guard Set(allOptions).count == allOptions.count else {
            throw AddingError.duplicateOptions(allOptions)
        }

        var newOptions = self.options
        newOptions[question] = allOptions

        return BasicQuizBuilder(
            questions: questions + [question],
            options: newOptions,
            correctAnswers: correctAnswers + [(question, [answer])])
    }

    public func build() -> BasicQuiz {
        BasicQuiz(questions: questions, options: options, correctAnswers: correctAnswers)
    }
}

extension BasicQuizBuilder {
    public init(multipleAnswerQuestion: String, options: NonEmptyOptions, answers: NonEmptyOptions) throws {
        try add(multipleAnswerQuestion: multipleAnswerQuestion, options: options, answers: answers)
    }

    public mutating func add(multipleAnswerQuestion: String, options: NonEmptyOptions, answers: NonEmptyOptions) throws {
        let question = Question.multipleAnswer(multipleAnswerQuestion)
        let allOptions = options.all
        let allAnswers = answers.all

        guard Set(allOptions).count == allOptions.count else {
            throw AddingError.duplicateOptions(allOptions)
        }

        guard Set(allAnswers).isSubset(of: Set(allOptions)) else {
            throw AddingError.missingAnswerInOptions(answer: allAnswers, options: allOptions)
        }

        var newOptions = self.options
        newOptions[question] = allOptions

        self = BasicQuizBuilder(
            questions: questions + [question],
            options: newOptions,
            correctAnswers: correctAnswers + [(question, allAnswers)]
        )
    }
}
