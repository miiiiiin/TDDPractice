//
//  Extensions+String.swift
//  PokemonExample
//
//  Created by Running Raccoon on 2022/02/16.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
