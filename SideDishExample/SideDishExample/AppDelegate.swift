//
//  AppDelegate.swift
//  SideDishExample
//
//  Created by Running Raccoon on 2022/02/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        
        let sceneCoordinator = SceneCoordinator(window: window!)
        let sidedishUseCase = SidedishUseCase()
        let viewModel = MainViewModel(title: "", sceneCoordinator: sceneCoordinator, sidedishUseCase: sidedishUseCase)
        sceneCoordinator.transition(to: Scene.main(viewModel), using: .root, animated: false)
        
        return true
    }
}

