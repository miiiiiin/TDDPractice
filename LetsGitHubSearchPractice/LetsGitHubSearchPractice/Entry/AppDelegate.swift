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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = SearchRepositoryViewController()
        window?.rootViewController = UINavigationController(rootViewController: SearchRepositoryViewController())
        window?.makeKeyAndVisible()
        
        return true
    }

}

