//
//  DemoQuizData.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 27/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import QuizEngine

let demoQuiz = try!
    BasicQuizBuilder(
        singleAnswerQuestion: "What's Mike's nationality?",
        options: .init("Canadian", "American", "Greek"),
        answer: "Greek"
    )
    .adding(
        multipleAnswerQuestion: "What are Caio's nationalities?",
        options: .init("Portuguese", "American", "Brazilian"),
        answer: .init("Portuguese", "Brazilian")
    )
    .adding(
        singleAnswerQuestion: "What's the capital of Brazil?",
        options: .init("Sao Paulo", "Rio de Janeiro", "Brasilia"),
        answer: "Brasilia"
    )
    .build()

