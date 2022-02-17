//
//  PokemonNavigatorMock.swift
//  PokemonExampleTests
//
//  Created by Running Raccoon on 2022/02/16.
//

import RxSwift
@testable import PokemonExample

class PokemonNavigatorMock: PokemonNavigatorType {
    var toPokemonListCallsCount = 0
    
    func toPokemonList() {
        toPokemonListCallsCount += 1
    }
    
    var toPokemonDetailsCallsCount = 0
    var toPokemonDetailsReceivedInvocations: [(String, String)] = []
    
    func toPokemonDetails(title: String, url: String) {
        toPokemonDetailsCallsCount += 1
        toPokemonDetailsReceivedInvocations.append((title, url))
    }    
}
