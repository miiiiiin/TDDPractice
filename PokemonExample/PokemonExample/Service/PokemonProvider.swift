//
//  PokemonProvider.swift
//  PokemonExample
//
//  Created by Running Raccoon on 2022/02/16.
//

import Foundation

protocol PokemonProviderType {
    
}

class PokemonProvider: PokemonProviderType {
    
    private struct Constants {
        static let baseUrl = "https://pokeapi.co/api/v2"
        static let pokemonPath = "pokemon"
    }

    init() {
        
    }
}
