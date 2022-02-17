//
//  PokemonListViewModel.swift
//  PokemonExample
//
//  Created by Running Raccoon on 2022/02/16.
//

import RxSwift
import RxCocoa

struct PokemonListViewModelInput {
    let itemSelected: Driver<Int>
    let listBottomReached: Driver<Void>
}

struct PokemonListViewModelOutput {
    let pokemonList: Driver<[PokemonListItem]>
    let itemSelected: Driver<Void>
}

protocol PokemonListViewModelType {
    func transform(input: PokemonListViewModelInput) -> PokemonListViewModelOutput
}

class PokemonListViewModel: PokemonListViewModelType {
    
    private var items = [PokemonListItem]()
    private var nextPageUrl: String?
    
    private let provider: PokemonProviderType
    private let navigator: PokemonNavigatorType
 
    init(provider: PokemonProviderType, navigator: PokemonNavigatorType) {
        self.provider = provider
        self.navigator = navigator
    }
    
    func transform(input: PokemonListViewModelInput) -> PokemonListViewModelOutput {
        
        let items = input.listBottomReached
            .asObservable()
            .startWith(())
            .filter { self.nextPageUrl != nil || self.items.isEmpty }
            .flatMapLatest { _ in
                self.provider.getPokemonList(customUrl: self.nextPageUrl)
            }
            .do(onNext: { result in
                if case let .success(response) = result {
                    let newItems = response.results.map { $0.toPokemonListItem() }
                    self.items.append(contentsOf: newItems)
                    self.nextPageUrl = response.next
                    debugPrint("next check: \(response.next)")
                }
            })
            .map { _ in self.items }
            .asDriver(onErrorJustReturn: [])
        
        let itemSelected = input.itemSelected
            .asObservable()
            .do(onNext: { index in
                debugPrint("selected index: \(index)")
                if index < self.items.count {
                    let pokemon = self.items[index]
                    self.navigator.toPokemonDetails(title: pokemon.name, url: pokemon.detailsUrl)
                }
            })
            .map { _ in () }
            .asDriver(onErrorJustReturn: ())
                
        return PokemonListViewModelOutput(pokemonList: items, itemSelected: itemSelected)
    }
}
