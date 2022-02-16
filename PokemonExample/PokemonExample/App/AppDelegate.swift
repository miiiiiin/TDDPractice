//
//  AppDelegate.swift
//  PokemonExample
//
//  Created by Running Raccoon on 2022/02/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            Application.shared.start(in: window)
        }
        return true
    }


}

