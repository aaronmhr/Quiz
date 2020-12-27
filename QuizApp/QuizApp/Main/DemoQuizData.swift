//
//  DemoQuizData.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 27/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import QuizEngine

let question1 = Question.singleAnswer("What's Mike's nationality?")
let question2 = Question.multipleAnswer("What's Caio's nationalities?")

let questions = [question1, question2]

let option1 = "Canadian"
let option2 = "American"
let option3 = "Greek"
let options1 = [option1, option2, option3]

let option4 = "Portuguese"
let option5 = "American"
let option6 = "Brazilian"
let options2 = [option4, option5, option6]

let options = [question1: options1, question2: options2]
let correctAnswers = [(question1, [option3]), (question2, [option4, option6])]