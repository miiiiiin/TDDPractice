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
        
        let output = viewModel.transform(input: PokemonListViewModelInput(itemSelected: .never(), listBottomReached: listBottomReached))
        
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
        
        let output = viewModel.transform(input: PokemonListViewModelInput(itemSelected: .never(), listBottomReached: .never()))
        
        XCTAssertEqual(try output.pokemonList.toBlocking().first(), [])
    }
    
    func testSelectingItems() {
        
        let selectItems = scheduler.createHotObservable([
            .next(1, 2),
            .next(2, 0),
            .next(3, 7)
        ])
        .asDriver(onErrorJustReturn: 0)
        
        let output = viewModel.transform(input: PokemonListViewModelInput(itemSelected: selectItems, listBottomReached: .never()))
        
        let pokemonList = scheduler.createObserver([PokemonListItem].self)
        let itemSelected = scheduler.createObserver(Void.self)
        
        output.pokemonList
            .drive(pokemonList)
            .disposed(by: disposeBag)
        
        output.itemSelected
            .drive(itemSelected)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        debugPrint("detailcount: \(navigator.toPokemonDetailsCallsCount), \(navigator.toPokemonDetailsReceivedInvocations.last?.0), \(PokemonListResponse.stub1().results[0].name)")
        
        XCTAssertEqual(navigator.toPokemonDetailsCallsCount, 2)
        XCTAssertEqual(navigator.toPokemonDetailsReceivedInvocations.first?.0, PokemonListResponse.stub1().results[2].name.capitalizingFirstLetter())
        XCTAssertEqual(navigator.toPokemonDetailsReceivedInvocations.first?.1, PokemonListResponse.stub1().results[2].url)
        XCTAssertEqual(navigator.toPokemonDetailsReceivedInvocations.last?.0, PokemonListResponse.stub1().results[0].name.capitalizingFirstLetter())
        XCTAssertEqual(navigator.toPokemonDetailsReceivedInvocations.last?.1, PokemonListResponse.stub1().results[0].url)
        
    }
}
