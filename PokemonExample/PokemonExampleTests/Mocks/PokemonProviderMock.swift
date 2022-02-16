//
//  PokemonProviderMock.swift
//  PokemonExampleTests
//
//  Created by Running Raccoon on 2022/02/16.
//

import RxSwift
@testable import PokemonExample

class PokemonProviderMock: PokemonProviderType {
    var getPokemonListFailure = false
    
    func getPokemonList(customUrl: String?) -> Single<PokemonListResult> {
        guard !getPokemonListFailure else {
            return .just(.failure(HTTPServiceError.invalidResponse))
        }
        
        if customUrl == nil {
            
        }
        
        return .just(.failure(HTTPServiceError.invalidResponse))
    }
}
