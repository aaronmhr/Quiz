//
//  BasicQuizBuilderTest.swift
//  QuizAppTests
//
//  Created by Aaron Huánuco on 27/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest

struct BasicQuiz {

}

struct BasicQuizBuilder {
    func build() -> BasicQuiz? {
        nil
    }
}

class BasicQuizBuilderTest: XCTestCase {
    func test_empty() {
        let sut = BasicQuizBuilder()

        XCTAssertNil(sut.build())
    }
}
