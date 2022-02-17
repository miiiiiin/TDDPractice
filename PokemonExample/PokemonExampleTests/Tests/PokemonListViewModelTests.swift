//
//  PokemonListViewModelTests.swift
//  PokemonExampleTests
//
//  Created by Running Raccoon on 2022/02/16.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking
@testable import PokemonExample
import RxTest

class PokemonListViewModelTests: XCTestCase {

    var provider: PokemonProviderMock!
    var navigator: PokemonNavigatorMock!
    var viewModel: PokemonListViewModelType!
    var scheduler: TestScheduler!
    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        
        provider = PokemonProviderMock()
        navigator = PokemonNavigatorMock()
        viewModel = PokemonListViewModel(provider: provider, navigator: navigator)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    func testLoadingItems() {
        
        let listBottomReached = scheduler.createColdObservable([
            .next(1, ()),
            .next(2, ()),
            .next(3, ())
        ])
        .asDriver(onErrorJustReturn: ())
        
        let output = viewModel.transform(input: PokemonListViewModelInput(listBottomReached: listBottomReached))
        
        let pokemonList = scheduler.createObserver([PokemonListItem].self)
        
        output.pokemonList
            .drive(pokemonList)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        
        debugPrint("pokemon debug : \(pokemonList.events), \(pokemonList)")
        
        XCTAssertEqual(pokemonList.events, [
            .next(0, PokemonListResponse.stub1PokemonListItems()),
            .next(1, PokemonListResponse.stub1PokemonListItems() + PokemonListResponse.stub2PokemonListItems()),
            .next(2, PokemonListResponse.stub1PokemonListItems() + PokemonListResponse.stub2PokemonListItems() + PokemonListResponse.stub3PokemonListItems()),
        ])
    }
    
    func testLoadingItemsFailure() {
        provider.getPokemonListFailure = true
        
        let output = viewModel.transform(input: PokemonListViewModelInput(listBottomReached: .never()))
        
        XCTAssertEqual(try output.pokemonList.toBlocking().first(), [])
    }

}
