//
//  MultipleSelectionStoreTests.swift
//  QuizAppTests
//
//  Created by Aaron Huánuco on 25/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
@testable import QuizApp

class MultipleSelectionStoreTests: XCTestCase {
    func test_selectOption_togglesState() {
        var sut = makeSUT(options: ["o0", "o1"])
        XCTAssertFalse(sut.options[0].isSelected)

        sut.options[0].select()
        XCTAssertTrue(sut.options[0].isSelected)

        sut.options[0].select()
        XCTAssertFalse(sut.options[0].isSelected)
    }

    func test_canSubmit_whenAtLeastOneOptionIsSelected() {
        var sut = makeSUT(options: ["o0", "o1"])
        XCTAssertFalse(sut.canSubmit)

        sut.options[0].select()
        XCTAssertTrue(sut.canSubmit)

        sut.options[0].select()
        XCTAssertFalse(sut.canSubmit)

        sut.options[1].select()
        XCTAssertTrue(sut.canSubmit)
    }

    func test_submit_notifiesHandlerWithSelectedOptions() {
        var submittedOptions = [[String]]()
        var sut = makeSUT(options: ["o0", "o1"], handler: {
            submittedOptions.append($0)
        })

        sut.submit()
        XCTAssertEqual(submittedOptions, [])

        sut.options[0].select()
        sut.submit()
        XCTAssertEqual(submittedOptions, [["o0"]])


        sut.options[1].select()
        sut.submit()
        XCTAssertEqual(submittedOptions, [["o0"], ["o0", "o1"]])
    }

    // MARK: - Helpers
    private func makeSUT(options: [String] = [], handler: @escaping ([String]) -> Void = { _ in }) -> MultipleSelectionStore {
        MultipleSelectionStore(options: options, handler: handler)
    }
}
