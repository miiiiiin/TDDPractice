//
//  PokemonListViewModel.swift
//  PokemonExample
//
//  Created by Running Raccoon on 2022/02/16.
//

import RxSwift

struct PokemonListViewModelInput {
    
}

struct PokemonListViewModelOutput {
    
}

protocol PokemonListViewModelType {
    func transform(input: PokemonListViewModelInput) -> PokemonListViewModelOutput
}

class PokemonListViewModel: PokemonListViewModelType {
    
    private let provider: PokemonProviderType
    private let navigator: PokemonNavigatorType
 
    init(provider: PokemonProviderType, navigator: PokemonNavigatorType) {
        self.provider = provider
        self.navigator = navigator
    }
    
    func transform(input: PokemonListViewModelInput) -> PokemonListViewModelOutput {
        return PokemonListViewModelOutput()
    }
}
