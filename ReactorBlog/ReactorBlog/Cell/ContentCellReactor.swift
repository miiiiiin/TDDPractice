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
//        var isWebPageRead: Bool
        
//        let thumbnail: URL?
//        let name: String
//        let title: String
//        let date: Date
//        let kind: PostKind
        let url: URL
    }
    
    var initialState: State
    let provider: ServiceProviderType

    init(post: Post, provider: ServiceProviderType) {
        self.provider = provider
        
        self.initialState = State(url: post.url)
    }
}
