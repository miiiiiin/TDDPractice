//
//  StringTests.swift
//  PokemonExampleTests
//
//  Created by Running Raccoon on 2022/02/17.
//

import XCTest
@testable import PokemonExample

class StringTests: XCTestCase {

    func testCapitalizingFirstLetterEmpty() {
        XCTAssertEqual("".capitalizingFirstLetter(), "")
    }

    func testCapitalizingFirstLetterAllLowercased() {
        XCTAssertEqual("ditto".capitalizingFirstLetter(), "Ditto")
    }

    func testCapitalizingFirstLetterAllUppercased() {
        XCTAssertEqual("DITTO".capitalizingFirstLetter(), "DITTO")
    }

    func testCapitalizingFirstLetterMixedCaseFirstUppercased() {
        XCTAssertEqual("DiTTo".capitalizingFirstLetter(), "DiTTo")
    }

    func testCapitalizingFirstLetterMixedCaseFirstLowercased() {
        XCTAssertEqual("dITtO".capitalizingFirstLetter(), "DITtO")
    }
}
