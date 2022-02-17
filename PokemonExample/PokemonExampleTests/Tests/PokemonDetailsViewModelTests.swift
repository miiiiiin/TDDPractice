//
//  PokemonDetailsViewModelTests.swift
//  PokemonExampleTests
//
//  Created by Running Raccoon on 2022/02/17.
//

import XCTest
import RxSwift
import RxCocoa
//import RxTest
import RxBlocking
@testable import PokemonExample

class PokemonDetailsViewModelTests: XCTestCase {

    var provider: PokemonProviderMock!
    var navigator: PokemonNavigatorMock!
    var viewModel: PokemonDetailsViewModelType!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        provider = PokemonProviderMock()
        navigator = PokemonNavigatorMock()
        viewModel = PokemonDetailsViewModel(provider: provider, url: "")
        disposeBag = DisposeBag()
    }
    
    
    func testOutputSuccess() {
        let response = PokemonDetailsResponse.stub(
            name: "ditto",
            imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png",
            abilities: ["limber", "imposter"],
            types: ["normal", "poison"],
            weight: 40,
            height: 3)

        provider.getPokemonDetailsReturnValue = .just(.success(response))

        let output = viewModel.transform()

        XCTAssertEqual(try output.name.toBlocking().first(), "Ditto")
        XCTAssertEqual(try output.imageUrl.toBlocking().first(), "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png")
        XCTAssertEqual(try output.abilities.toBlocking().first(), "Abilities: limber, imposter")
        XCTAssertEqual(try output.types.toBlocking().first(), "Types: normal, poison")
        XCTAssertEqual(try output.weight.toBlocking().first(), "Weight: 40 kg")
        XCTAssertEqual(try output.height.toBlocking().first(), "Height: 3 cm")
    }

    func testOutputSuccessSingleAbilityAndType() {
        let response = PokemonDetailsResponse.stub(
            name: "pikachu",
            imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png",
            abilities: ["lightning-rod"],
            types: ["electric"],
            weight: 60,
            height: 4)

        provider.getPokemonDetailsReturnValue = .just(.success(response))

        let output = viewModel.transform()

        XCTAssertEqual(try output.name.toBlocking().first(), "Pikachu")
        XCTAssertEqual(try output.imageUrl.toBlocking().first(), "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png")
        XCTAssertEqual(try output.abilities.toBlocking().first(), "Abilities: lightning-rod")
        XCTAssertEqual(try output.types.toBlocking().first(), "Types: electric")
        XCTAssertEqual(try output.weight.toBlocking().first(), "Weight: 60 kg")
        XCTAssertEqual(try output.height.toBlocking().first(), "Height: 4 cm")
    }

    func testOutputSuccessEmptyStrings() {
        let response = PokemonDetailsResponse.stub(
            name: "",
            imageUrl: "",
            abilities: [],
            types: [],
            weight: 0,
            height: 0)

        provider.getPokemonDetailsReturnValue = .just(.success(response))

        let output = viewModel.transform()

        XCTAssertEqual(try output.name.toBlocking().first(), "")
        XCTAssertEqual(try output.imageUrl.toBlocking().first(), "")
        XCTAssertEqual(try output.abilities.toBlocking().first(), "Abilities: ")
        XCTAssertEqual(try output.types.toBlocking().first(), "Types: ")
        XCTAssertEqual(try output.weight.toBlocking().first(), "Weight: 0 kg")
        XCTAssertEqual(try output.height.toBlocking().first(), "Height: 0 cm")
    }
    
    func testOutputFailure() {
        
        provider.getPokemonDetailsReturnValue = .just(.failure(HTTPServiceError.invalidResponse))
        
        let output = viewModel.transform()
        
        XCTAssertThrowsError(try output.name.toBlocking(timeout: 1).first())
        XCTAssertThrowsError(try output.imageUrl.toBlocking(timeout: 1).first())
    }
}
