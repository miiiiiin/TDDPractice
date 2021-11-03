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

enum SortType {
    case titleAsc
    case recency
}

final class MainViewReactor: Reactor, Stepper {

    var steps = PublishRelay<Step>()
    
    enum Action {
        case refresh
        case loadMore
        case loadSearchHistory
        case updateSearchWord(String)
        case updateSearchHistory
        case updateSort(SortType)
        case updateFilter(FilterType)
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setRefreshing(Bool)
        case setPosts([Post])
        case setSearchWord(String)
        case appendPosts([Post], Bool)
        case setSearchHistory(String)
        case setSearchHistories([String])
        case applySortType(SortType)
        case setFilterType(FilterType)
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
    lazy var error = errorRelay.asObservable()
    
    let initialState: State = State()
    let provider: ServiceProviderType
    
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
            .map { result in
                return Mutation.setPosts(result.documents)
            }
            .catchError { error in
                print("fetch error: \(error as? ErrorResponse)")
                self.errorRelay.accept(error as? ErrorResponse)
                return .empty()
            }            
            return .concat([startRefreshing, search, stopRefreshing])
            
        case .loadMore:
            if self.currentState.isRefreshing { return .empty() }
            if self.currentState.isLoading { return .empty() }
            if self.currentState.isPageEnd { return .empty() }
            
            let startLoading = Observable.just(Mutation.setLoading(true))
            let stopLoading = Observable.just(Mutation.setLoading(false))
            
            let search = self.provider.searchService.searchPost(
                query: self.currentState.searchedKeyword,
                filter: self.currentState.filterType,
                page: self.currentState.page,
                size: 25
            )
            .asObservable()
            .map { result in
                return Mutation.appendPosts(result.documents, result.meta.isEnd)
            }
            .catchError { error in
                self.errorRelay.accept(error as? ErrorResponse)
                return .empty()
            }
            
            return .concat([startLoading, search, stopLoading]) // concat?
            
        case .loadSearchHistory:
            return self.provider.searchService.getSearchHistory()
                .map { histories -> Mutation in
                    Mutation.setSearchHistories(histories)
                }
            
        case let .updateSort(type):
            return .just(.applySortType(type))
            
        case let .updateFilter(type):
            return .just(.setFilterType(type))
            
        case let .updateSearchWord(keyword):
            return .just(.setSearchWord(keyword.trimmingCharacters(in: .whitespacesAndNewlines)))
        
        case .updateSearchHistory:
            return .just(.setSearchHistory(self.currentState.query))
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setLoading(isLoading):
            state.isLoading = isLoading
            
        case let .setRefreshing(isRefreshing):
            state.isRefreshing = isRefreshing
            
        case let .setSearchWord(keyword):
            state.query = keyword
            
        case let .setPosts(posts):
            state.isPageEnd = false
            state.page = 2
            state.items = posts.sorted(by: { $0.title < $1.title })
            
            state.searchedKeyword = state.query
            
            print("set posts check: \(posts)")
        
        case let .appendPosts(posts, isEnd):
            state.isPageEnd = isEnd
            state.page += 1
            state.items += posts.sorted(by: { $0.title < $1.title })
            
            print("check state items:  \(state.items.count), \(state.items)")
        
        case let .setSearchHistory(history):
            print("set search history reduce: \(history)")
            if state.searchHistory.contains(history) {
                state.searchHistory.removeAll(where: { $0 == history || $0 == ""})
                state.searchHistory.append(history)
            } else {
                state.searchHistory.removeAll(where: { $0 == "" })
                state.searchHistory.append(history)
            }
            
        case let .setSearchHistories(histories):
            print("set search histories: \(histories)")
            state.searchHistory = histories
            
        case let .applySortType(type):
            switch type {
            case .titleAsc:
                state.items.sort(by: { $0.title < $1.title })
                
            case .recency:
                state.items.sort(by: { $0.dateTime > $1.dateTime })
            }
            
        case let .setFilterType(type):
            state.filterType = type
            
        default:
            break
        }
        
        return state
    }
}
