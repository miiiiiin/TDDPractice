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
    
    
    struct State {
        var query: String = ""
        var isRefreshing: Bool = false
        var searchedKeyword: String = ""
    }
    
    
    let initialState: State = State()
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }    
}
