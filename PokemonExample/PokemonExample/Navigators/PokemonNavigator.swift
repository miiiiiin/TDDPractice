//
//  PokemonNavigator.swift
//  PokemonExample
//
//  Created by Running Raccoon on 2022/02/16.
//

import Foundation
import UIKit

protocol PokemonNavigatorType {
    func toPokemonList()
    func toPokemonDetails(title: String, url: String)
}

class PokemonNavigator: PokemonNavigatorType {
    
    private let navigationController: UINavigationController
    private let provider: PokemonProviderType
    
    init(navigationController: UINavigationController, provider: PokemonProviderType) {
        self.navigationController = navigationController
        self.provider = provider
    }
    
    func toPokemonList() {
        
    }
    
    func toPokemonDetails(title: String, url: String) {
        
    }
    
}
