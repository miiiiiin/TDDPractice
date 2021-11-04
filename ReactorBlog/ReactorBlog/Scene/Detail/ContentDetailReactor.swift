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
        case navigateToURLPage
    }
    
    enum Mutation {
        
    }
    
    struct State {
        let thumbnail: URL?
        let name: String
        let title: String
        let contents: String
        let date: Date
        let url: URL
        let kind: PostKind
    }
    
    let initialState: State
    let provider: ServiceProviderType
    
    init(post: Post, provider: ServiceProviderType) {
        self.provider = provider
        
        self.initialState = State(thumbnail: post.thumbnail,
                                  name: post.name,
                                  title: post.title,
                                  contents: post.contents ?? "",
                                  date: post.dateTime,
                                  url: post.url,
                                  kind: post.kind)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .navigateToURLPage:
            print("navigaget teo page url: \(self.currentState.url)")
            self.provider.searchService.setCheckedURL(url: self.currentState.url)
            self.steps.accept(BlogStep.urlPage(url: self.currentState.url))
            return .empty()
        }
    }
}
