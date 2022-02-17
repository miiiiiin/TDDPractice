//
//  PokemonDetailsResponse.swift
//  PokemonExample
//
//  Created by Running Raccoon on 2022/02/17.
//

import Foundation

struct PokemonAbilityResponse: Decodable {
    struct PokemonAbilityDetailsResponse: Decodable {
        let name: String
    }
    let ability: PokemonAbilityDetailsResponse
}

struct PokemonTypeResponse: Decodable {
    struct PokemonTypeDetailsResponse: Decodable {
        let name: String
    }
    let type: PokemonTypeDetailsResponse
}

struct SpritesResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }

    let frontDefault: String
}

struct PokemonDetailsResponse: Decodable {
    let name: String
    let abilities: [PokemonAbilityResponse]
    let types: [PokemonTypeResponse]
    let sprites: SpritesResponse
    let weight: Int
    let height: Int
}

extension PokemonDetailsResponse {
    func toPokemonDetails() -> PokemonDetails {
        PokemonDetails(name: name.capitalizingFirstLetter(),
                       imageUrl: sprites.frontDefault,
                       abilities: abilities.map { $0.ability.name },
                       types: types.map { $0.type.name },
                       weight: weight,
                       height: height)
    }
}
