//
//  Application.swift
//  PokemonExample
//
//  Created by Running Raccoon on 2022/02/16.
//

import UIKit

class Application {
    
    static let shared = Application()
    
    func start(in window: UIWindow) {
        let navigationViewController = UINavigationController()
        let pokemonProvider = PokemonProvider()
        let pokemonNavigator = PokemonNavigator(navigationController: navigationViewController, provider: pokemonProvider)
        pokemonNavigator.toPokemonList()
        
        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
    }
}
