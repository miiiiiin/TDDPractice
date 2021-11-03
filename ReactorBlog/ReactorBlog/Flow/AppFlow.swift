//
//  AppFlow.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/26.
//

import UIKit
import RxSwift
import RxCocoa
import RxFlow

final class AppFlow: Flow {
    
    private let provider: ServiceProviderType
    
    private lazy var rootViewController = UINavigationController()
    
    var root: Presentable {
        self.rootViewController
    }
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? BlogStep else { return .none }
        switch step {
        case .main:
            return navigateToMain()
            
        case let .postDetail(post):
            return navigateToPostDetail(post: post)
        }
    }
    
    
    deinit {
        print("AppFlow deinit: \(type(of: self)): \(#function)")
    }
}


// MARK: - Navigation -

extension AppFlow {
    
    private func navigateToMain() -> FlowContributors {
        let reactor = MainViewReactor(provider: self.provider)
        let viewController = MainViewController(reactor: reactor)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func navigateToPostDetail(post: Post) -> FlowContributors {
        let reactor = ContentDetailReactor(post: post, provider: self.provider)
        let viewController = ContentDetailViewController(reactor: reactor)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
}
