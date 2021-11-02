//
//  ContentCellReactor.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import ReactorKit

final class ContentCellReactor: Reactor {
   
    enum Action {
        case checkWebPageRead(URL)
        
    }
    
    enum Mutation {
        case setIsWebPageRead(Bool)
    }
    
    struct State {
        var isWebPageRead: Bool
        let thumbnail: URL?
        let name: String
        let title: String
        let date: Date
        let kind: PostKind
        let url: URL
    }
    
    var initialState: State
    let provider: ServiceProviderType
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let urlEventMutation = self.provider.searchService.urlEvent
            .map { urls in
                Mutation.setIsWebPageRead(urls.contains(self.currentState.url.absoluteString))
            }
        print("cellreactor transform: \(mutation), \(urlEventMutation), \(self.currentState.url)")
        return .merge(mutation, urlEventMutation)
    }
    
    init(post: Post, provider: ServiceProviderType) {
        print("cell reactor post: \(post.blogName)")
        self.provider = provider
        
        self.initialState = State(isWebPageRead: provider.searchService.isCheckedURL(url: post.url),
                                  thumbnail: post.thumbnail,
                                  name: post.blogName ?? "",
                                  title: post.title,
                                  date: post.dateTime,
                                  kind: post.kind,
                                  url: post.url)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .checkWebPageRead(url):
            print("checkwebpageread check: \(url)")
            return .just(.setIsWebPageRead(self.currentState.url == url))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        print("contentcell mustation: \(mutation)")
        switch mutation {
        case let .setIsWebPageRead(isWebPageRead):
            state.isWebPageRead = isWebPageRead
        }
        
        return state
    }
}
