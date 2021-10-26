//
//  AppDelegate.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/26.
//

import UIKit
import RxSwift
import RxFlow

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var coordinator = FlowCoordinator()
    private let disposeBag = DisposeBag()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
    
        
        let appFlow = AppFlow()
        
        Flows.use(appFlow, when: .created) { root in
            self.window?.rootViewController = root
        }
        
        self.coordinator.coordinate(flow: appFlow)
        
        return true
    }
}
