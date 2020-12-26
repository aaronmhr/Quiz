//
//  MultipleAnswersQuestionSnapshotTest.swift
//  QuizAppTests
//
//  Created by Aaron Huánuco on 25/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
@testable import QuizApp

class MultipleAnswersQuestionSnapshotTest: XCTestCase {
    func test() {
        let sut = MultipleAnswerQuestion(
            title: "A title",
            question: "A question",
            store: .init(options: ["Option 1", "Option 2"], handler: { _ in }))
            .viewControllerHosted()


        assert(snapshot: sut.snapshot(), named: "two_options")
    }
}
