//
//  ContentDetailReactor.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/11/03.
//

import ReactorKit
import RxSwift
import RxCocoa
import RxFlow

final class ContentDetailReactor: Reactor, Stepper {
    
    
       
    var steps = PublishRelay<Step>()
    
    enum Action {
        
    }
    
    enum Muatation {
        
    }
    
    struct State {
        
    }
    
    let initialState: State = State()
    let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
    
    
}
