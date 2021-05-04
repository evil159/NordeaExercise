//
//  CustomAsserts.swift
//  NordeaExerciseTests
//
//  Created by Laitarenko Roman on 2.5.2021.
//

import XCTest

func assertMethodCall(_ methodCall: Bool, file: StaticString = #file, line: UInt = #line) {
    if !methodCall {
        XCTFail("Expected method wasn't called", file: file, line: line)
    }
}

func assertMethodNotCall(_ methodCall: Bool, file: StaticString = #file, line: UInt = #line) {
    if methodCall {
        XCTFail("Expected method was called", file: file, line: line)
    }
}
