//
//  MainViewReactor.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/26.
//

import ReactorKit
import RxSwift
import RxCocoa
import RxFlow

final class MainViewReactor: Reactor, Stepper {

    
    let provider: ServiceProviderType
    var steps = PublishRelay<Step>()
    
    enum Action {
        case refresh
        
    }
    
    enum Mutation {
        case setRefreshing(Bool)
        case setPosts([Void]) // fixme
    }
    
    
    struct State {
        var query: String = ""
        var filterType: FilterType = .all
        var page: Int = 1
        var isRefreshing: Bool = false
        
        var searchedKeyword: String = ""
    }
    
    
    private let errorRelay = PublishRelay<Error>()
    let initialState: State = State()
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            if self.currentState.isRefreshing { return .empty() }
            
            let startRefreshing = Observable.just(Mutation.setRefreshing(true))
            let stopRefreshing = Observable.just(Mutation.setRefreshing(false))
            
            let search = self.provider.searchService.searchPost(
                query: self.currentState.query,
                filter: self.currentState.filterType,
                page: self.currentState.page,
                size: 25
            )
            .asObservable()
            .map { list in
                return Mutation.setPosts([list]) // fixme
            }
//            .catchError { error in
//                self.errorRelay.accept(error)
//            }
            
            return .concat([startRefreshing, search, stopRefreshing])
        }
    }
}
