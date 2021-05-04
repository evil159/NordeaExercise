//
//  XCTestCase+Eventually.swift
//  NordeaExerciseTests
//
//  Created by Laitarenko Roman on 2.5.2021.
//

import XCTest

extension XCTestCase {
    func eventually(timeout: TimeInterval = 0.01, closure: @escaping () -> Void) {
        let expectation = expectation(description: "")

        DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
}
