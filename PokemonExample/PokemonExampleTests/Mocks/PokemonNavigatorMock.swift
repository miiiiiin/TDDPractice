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
    
    func toPokemonDetails(title: String, url: String) {
        
    }
    
}
