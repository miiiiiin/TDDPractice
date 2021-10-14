//
//  Scene.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/12.
//

import Foundation

protocol TargetScene {
    var transition: SceneTransitionType { get }
}

enum Scene {
    case search(SearchViewModel)
}

extension Scene: TargetScene {
    
    var transition: SceneTransitionType {
        switch self {
        case .search(let viewModel):
            var vc = SearchViewController()
            vc.bind(to: viewModel)
            return .root(vc)
        }
    }
}
