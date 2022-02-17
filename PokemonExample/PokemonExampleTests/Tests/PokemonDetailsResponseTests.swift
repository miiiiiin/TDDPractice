//
//  PokemonDetailsResponseTests.swift
//  PokemonExampleTests
//
//  Created by Running Raccoon on 2022/02/17.
//

import XCTest
@testable import PokemonExample

class PokemonDetailsResponseTests: XCTestCase {

    func testLoadingIvysaurResponse() {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "pokemon_details_response_ivysaur", withExtension: "json")
        let json = try! Data(contentsOf: url!)
        let response = try! JSONDecoder().decode(PokemonDetailsResponse.self, from: json)

        XCTAssertEqual(response.name, "ivysaur")
        XCTAssertEqual(response.abilities.count, 2)
        XCTAssertEqual(response.abilities.first?.ability.name, "overgrow")
        XCTAssertEqual(response.abilities.last?.ability.name, "chlorophyll")
        XCTAssertEqual(response.types.first?.type.name, "grass")
        XCTAssertEqual(response.types.last?.type.name, "poison")
        XCTAssertEqual(response.sprites.frontDefault, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png")
        XCTAssertEqual(response.weight, 130)
        XCTAssertEqual(response.height, 10)
    }

    func testIvysaurResponseConversionToModel() {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "pokemon_details_response_ivysaur", withExtension: "json")
        let json = try! Data(contentsOf: url!)
        let response = try! JSONDecoder().decode(PokemonDetailsResponse.self, from: json)
        let details = response.toPokemonDetails()

        XCTAssertEqual(details.name, "Ivysaur")
        XCTAssertEqual(details.abilities, ["overgrow", "chlorophyll"])
        XCTAssertEqual(details.types, ["grass", "poison"])
        XCTAssertEqual(details.imageUrl, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png")
        XCTAssertEqual(details.weight, 130)
        XCTAssertEqual(details.height, 10)
    }

}
