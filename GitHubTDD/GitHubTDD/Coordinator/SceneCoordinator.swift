//
//  SceneCoordinator.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/12.
//

import Foundation
import UIKit
import RxSwift

class SceneCoordinator: NSObject, SceneCoordinatorType {
    
    static var shared: SceneCoordinator!
    
    fileprivate var window: UIWindow
    public var currentViewController: UIViewController {
        didSet {
            currentViewController.navigationController?.delegate = self
        }
    }
    
    required init(window: UIWindow) {
        self.window = window
        currentViewController = window.rootViewController ?? UINavigationController()
    }

    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        var controller = viewController
        if let tabBarController = controller as? UITabBarController {
            guard let selectedViewController = tabBarController.selectedViewController else {
                return tabBarController
            }
            controller = selectedViewController

            return actualViewController(for: controller)
        }

        if let navigationController = viewController as? UINavigationController {
            controller = navigationController.viewControllers.first!
            
            return actualViewController(for: controller)
        }
        return controller
    }
    
    func transition(to scene: TargetScene) -> Observable<Void> {
        let subject = PublishSubject<Void>()
        
        switch scene.transition {
        case let .root(viewController):
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            window.rootViewController = currentViewController
            subject.onCompleted()
        }
        
        return subject
            .asObservable()
            .take(1)
    }
}

// MARK: - UINavigationControllerDelegate -

extension SceneCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
}
