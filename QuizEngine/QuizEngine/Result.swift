//
//  Result.swift
//  QuizEngine
//
//  Created by Aaron Huánuco on 12/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

struct Result<Question: Hashable, Answer> {
    let answers: [Question: Answer]
    let score: Int
}
