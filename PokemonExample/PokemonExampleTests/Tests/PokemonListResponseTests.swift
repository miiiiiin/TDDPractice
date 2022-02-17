//
//  PokemonListResponseTests.swift
//  PokemonExampleTests
//
//  Created by Running Raccoon on 2022/02/17.
//

import XCTest
@testable import PokemonExample

class PokemonListResponseTests: XCTestCase {
    
    func testLoadingFiveItems() {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "pokemon_list_response_5_items", withExtension: "json")
        let json = try! Data(contentsOf: url!)
        let response = try! JSONDecoder().decode(PokemonListResponse.self, from: json)
        
        XCTAssertEqual(response.next, "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20")
        XCTAssertEqual(response.results.count, 5)
        XCTAssertEqual(response.results[2].name, "venusaur")
        XCTAssertEqual(response.results[3].url, "https://pokeapi.co/api/v2/pokemon/4/")
        XCTAssertEqual(response.results.last!.toPokemonListItem().name, "Charmeleon")
        XCTAssertEqual(response.results.last!.toPokemonListItem().detailsUrl, "https://pokeapi.co/api/v2/pokemon/5/")
    }
    
    func testLoadingNoItems() {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "pokemon_list_response_empty_results", withExtension: "json")
        let json = try! Data(contentsOf: url!)
        let response = try! JSONDecoder().decode(PokemonListResponse.self, from: json)
        
        XCTAssertEqual(response.next, "https://pokeapi.co/api/v2/pokemon?offset=10&limit=10")
        XCTAssertEqual(response.results.count, 0)
    }
    
    func testLoadingInvalidJson() {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "pokemon_list_response_invalid", withExtension: "json")
        let json = try! Data(contentsOf: url!)
        
        XCTAssertThrowsError(try JSONDecoder().decode(PokemonListResponse.self, from: json))
    }
}
