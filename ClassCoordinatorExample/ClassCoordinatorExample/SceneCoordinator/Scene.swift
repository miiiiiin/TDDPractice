//
//  Scene.swift
//  ClassCoordinatorExample
//
//  Created by Running Raccoon on 2022/02/15.
//

import UIKit

enum Scene {
    case login(LoginViewModel)
}

extension Scene {
    func viewController() -> UIViewController {
        switch self {
        case let .login(viewModel):
            var loginVC = LoginViewController()
            let navController = UINavigationController(rootViewController: loginVC)
            loginVC.bindViewModel(to: viewModel)
            return navController
        }
    }
}

