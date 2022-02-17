//
//  PokemonProvider.swift
//  PokemonExample
//
//  Created by Running Raccoon on 2022/02/16.
//

import Foundation
import RxSwift
import RxCocoa

typealias PokemonListResult = Result<PokemonListResponse, Error>
typealias PokemonDetailsResult = Result<PokemonDetailsResponse, Error>

protocol PokemonProviderType {
    func getPokemonList(customUrl: String?) -> Single<PokemonListResult>
    func getPokemonDetails(url: String) -> Single<PokemonDetailsResult>
}

class PokemonProvider: PokemonProviderType {
    
    private struct Constants {
        static let baseUrl = "https://pokeapi.co/api/v2"
        static let pokemonPath = "pokemon"
    }
    
    private let httpService: HTTPServiceType

    init(httpService: HTTPServiceType) {
        self.httpService = httpService
    }
    
    func getPokemonList(customUrl: String?) -> Single<PokemonListResult> {
        let defaultUrl = Constants.baseUrl + "/" + Constants.pokemonPath
        let url = customUrl ?? defaultUrl
        
        return httpService.get(url: url, responseType: PokemonListResponse.self)
    }
    
    func getPokemonDetails(url: String) -> Single<PokemonDetailsResult> {
        return httpService.get(url: url, responseType: PokemonDetailsResponse.self)
    }
}
