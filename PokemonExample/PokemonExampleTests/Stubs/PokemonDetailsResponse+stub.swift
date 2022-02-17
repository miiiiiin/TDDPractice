//
//  PokemonDetailsResponse+stub.swift
//  PokemonExampleTests
//
//  Created by Running Raccoon on 2022/02/17.
//

import Foundation
@testable import PokemonExample

extension PokemonDetailsResponse {
    static func stub(name: String,
                     imageUrl: String,
                     abilities: [String],
                     types: [String],
                     weight: Int,
                     height: Int) -> PokemonDetailsResponse {
        let abilities = abilities
            .map { PokemonAbilityResponse(ability: PokemonAbilityResponse.PokemonAbilityDetailsResponse(name: $0)) }

        let types = types
            .map { PokemonTypeResponse(type: PokemonTypeResponse.PokemonTypeDetailsResponse(name: $0)) }

        let sprites = SpritesResponse(frontDefault: imageUrl)

        return PokemonDetailsResponse(name: name,
                               abilities: abilities,
                               types: types,
                               sprites: sprites,
                               weight: weight,
                               height: height)
    }
}

