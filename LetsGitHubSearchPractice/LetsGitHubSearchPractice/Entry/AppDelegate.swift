//
//  AppDelegate.swift
//  LetsGitHubSearchPractice
//
//  Created by Running Raccoon on 2021/11/11.
//

import UIKit

//@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private let appDependency: AppDependency
    
    /// iOS 시스템에 의해 자동으로 호출되는 생성자
    private override init() {
        self.appDependency = AppDependency.resolve()
        print("main appdelegate")
//        super.init()
    }
    
    /// 테스트시에만 호출하는 생성자
    init(dependency: AppDependency) {
        print("appdelegate test")
        self.appDependency = dependency
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //        window = UIWindow(frame: UIScreen.main.bounds)
        //        window?.rootViewController = SearchRepositoryViewController()
        //        window?.rootViewController = UINavigationController(rootViewController: SearchRepositoryViewController())
        //        window?.makeKeyAndVisible()
        
        if let rootViewController = self.rootViewController() {
//            rootViewController.repositoryService = self.appDependency.repositoryService
//            rootViewController.urlOpener = self.appDependency.urlOpener
//            rootViewController.firebaseAnalytics = self.appDependency.firebaseAnalytics
        
            rootViewController.dependency = self.appDependency.searchRepositoryVCDependency
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

