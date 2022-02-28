//
//  JokesAPIProviderTests.swift
//  WoowaNetworkTestTests
//
//  Created by Running Raccoon on 2022/02/28.
//

import XCTest
@testable import WoowaNetworkTest

class JokesAPIProviderTests: XCTestCase {

    var sut: JokesAPIProvider!

    override func setUpWithError() throws {
        sut = JokesAPIProvider(isStub: true)
    }

    func test_fetchRandomJokes_success() {
        let expectation = XCTestExpectation()

        let expectedJoke = JokesAPI
            .randomJokes("Gro", "Hong", ["nerdy"])
            .sampleDecodable(JokeReponse.self)?.value

        sut.fetchRandomJoke(firstName: "Gro", lastName: "Hong", categories: ["nerdy"])
            .subscribe(onSuccess: { joke in
                XCTAssertEqual(expectedJoke?.joke, joke.joke)
                expectation.fulfill()
            })
            .dispose()
        wait(for: [expectation], timeout: 2.0)
    }
}
