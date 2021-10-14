//
//  AppDelegate.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/06.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.makeKeyAndVisible()

        let sceneCoordinator = SceneCoordinator(window: window!)
        SceneCoordinator.shared = sceneCoordinator
        
        let scheduler = RxScheduler()
        let githubService = GithubService(scheduler: scheduler)
        let viewModel = SearchViewModel(service: githubService, scheduler: scheduler)
        sceneCoordinator.transition(to: Scene.search(viewModel))
        
        return true
    }
}
