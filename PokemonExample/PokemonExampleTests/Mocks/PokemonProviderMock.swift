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
            return .just(.success(PokemonListResponse.stub1()))
        } else if customUrl == PokemonListResponse.stub1().next {
            return .just(.success(PokemonListResponse.stub2()))
        } else if customUrl == PokemonListResponse.stub2().next {
            return .just(.success(PokemonListResponse.stub3()))
        }
        
        return .just(.failure(HTTPServiceError.invalidResponse))
    }
}
