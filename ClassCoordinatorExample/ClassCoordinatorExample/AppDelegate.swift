//
//  AppDelegate.swift
//  ClassCoordinatorExample
//
//  Created by Running Raccoon on 2022/02/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let viewModel = LoginViewModel(dependencies: AppDependency.shared)
        let loginScene = Scene.login(viewModel)
        window?.rootViewController = loginScene.viewController()
        AppDependency.shared.coordinator.setRoot(viewController: window!.rootViewController!)
        
        return true
    }

}

