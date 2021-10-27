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
        case updateSearchWord(String)
        case loadSearchHistory
        
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setRefreshing(Bool)
        case setPosts([Post])
        case setSearchWord(String)
        case appendPosts([Post], Bool)
        case setSearchHistories([String])
    }
    
    
    struct State {
        var items: [Post] = []
        var query: String = ""
        var filterType: FilterType = .all
        var page: Int = 1
        var isPageEnd: Bool = false
        
        var isLoading: Bool = false
        var isRefreshing: Bool = false
        
        var searchedKeyword: String = ""
        var searchHistory: [String] = [""]
    }
    
    
    private let errorRelay = PublishRelay<ErrorResponse?>()
    let initialState: State = State()
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
    
    // 액션 바인딩 시 아래 메소드 통해 액션 케이스 실행
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            if self.currentState.isRefreshing { return .empty() }
            if self.currentState.isLoading { return .empty() }
            
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
                return Mutation.setPosts(list.documents)
            }
            .catchError { error in
                self.errorRelay.accept(error as? ErrorResponse)
                return .empty()
            }            
            return .concat([startRefreshing, search, stopRefreshing])
            
        case .loadSearchHistory:
            return self.provider.searchService.getSearchHistory()
                .map { histories -> Mutation in
                    Mutation.setSearchHistories(histories)
                }
            
        case let .updateSearchWord(keyword):
            return .just(.setSearchWord(keyword.trimmingCharacters(in: .whitespacesAndNewlines)))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setLoading(isLoading):
            state.isLoading = isLoading
            
        case let .setSearchWord(keyword):
            state.query = keyword
            
        case let .setPosts(posts):
            state.isPageEnd = false
            state.page = 2
            state.items = posts.sorted(by: { $0.title < $1.title })
            
            state.searchedKeyword = state.query
        
        case let .appendPosts(posts, isEnd):
            state.isPageEnd = isEnd
            state.page += 1
            state.items += posts.sorted(by: { $0.title < $1.title })
            
            print("check state items:  \(state.items.count), \(state.items)")
        
        case let .setSearchHistories(histories):
            state.searchHistory = histories
            
        default:
            break
        }
        
        print("reduce state: \(state), \(state.query)")
        return state
    }
}
