//
//  AppDelegate.swift
//  LetsGitHubSearchPractice
//
//  Created by Running Raccoon on 2021/11/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private let appDependency: AppDependency = AppDependency.resolve()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //        window = UIWindow(frame: UIScreen.main.bounds)
        //        window?.rootViewController = SearchRepositoryViewController()
        //        window?.rootViewController = UINavigationController(rootViewController: SearchRepositoryViewController())
        //        window?.makeKeyAndVisible()
        
        if let rootViewController = self.rootViewController() {
            rootViewController.repositoryService = self.appDependency.repositoryService
        }
        
        return true
    }
    
    private func rootViewController() -> SearchRepositoryViewController? {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: SearchRepositoryViewController())
        window?.makeKeyAndVisible()
        
        let navigationController = self.window?.rootViewController as? UINavigationController
        return navigationController?.viewControllers.first as? SearchRepositoryViewController
    }
}

