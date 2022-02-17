//
//  PokemonDetailsViewModel.swift
//  PokemonExample
//
//  Created by Running Raccoon on 2022/02/17.
//

import RxSwift
import RxCocoa
import UIKit.UIImage

struct PokemonDetailsViewModelOutput {
    let imageUrl: Driver<String>
    let name: Driver<String>
    let abilities: Driver<String>
    let types: Driver<String>
    let weight: Driver<String>
    let height: Driver<String>
}


protocol PokemonDetailsViewModelType {
    func transform() -> PokemonDetailsViewModelOutput
}

class PokemonDetailsViewModel: PokemonDetailsViewModelType {
    
    private let provider: PokemonProviderType
    private let url: String

    init(provider: PokemonProviderType, url: String) {
        self.provider = provider
        self.url = url
    }
    
    func transform() -> PokemonDetailsViewModelOutput {
        let response = provider.getPokemonDetails(url: url)
            .flatMap { result -> Single<PokemonDetails> in
                switch result {
                case .success(let response):
                    return .just(response.toPokemonDetails())
                case .failure:
                    return .never()
                }
            }
        
        return PokemonDetailsViewModelOutput(
            imageUrl: response.map { $0.imageUrl }.asDriver(onErrorJustReturn: ""),
            name: response.map { $0.name }.asDriver(onErrorJustReturn: "N/A"),
            abilities: response.map { "Abilities: \($0.abilities.joined(separator: ", "))" }.asDriver(onErrorJustReturn: ""),
            types: response.map { "Types: \($0.types.joined(separator: ", "))" }.asDriver(onErrorJustReturn: ""),
            weight: response.map { "Weight: \($0.weight) kg" }.asDriver(onErrorJustReturn: ""),
            height: response.map { "Height: \($0.height) cm" }.asDriver(onErrorJustReturn: ""))
    }
}
