//
//  PokemonListResponse+stub.swift
//  PokemonExampleTests
//
//  Created by Running Raccoon on 2022/02/16.
//

@testable import PokemonExample

extension PokemonListResponse {
    static func stub1() -> PokemonListResponse {
        PokemonListResponse(next: "https://pokeapi.co/api/v2/pokemon?offset=5&limit=5",
                            results: [
                                PokemonListResponseItem(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
                                PokemonListResponseItem(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
                                PokemonListResponseItem(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"),
                                PokemonListResponseItem(name: "charmander", url: "https://pokeapi.co/api/v2/pokemon/4/"),
                                PokemonListResponseItem(name: "charmeleon", url: "https://pokeapi.co/api/v2/pokemon/5/")
                            ])
    }

    static func stub1PokemonListItems() -> [PokemonListItem] {
        [
            PokemonListItem(name: "Bulbasaur", detailsUrl: "https://pokeapi.co/api/v2/pokemon/1/"),
            PokemonListItem(name: "Ivysaur", detailsUrl: "https://pokeapi.co/api/v2/pokemon/2/"),
            PokemonListItem(name: "Venusaur", detailsUrl: "https://pokeapi.co/api/v2/pokemon/3/"),
            PokemonListItem(name: "Charmander", detailsUrl: "https://pokeapi.co/api/v2/pokemon/4/"),
            PokemonListItem(name: "Charmeleon", detailsUrl: "https://pokeapi.co/api/v2/pokemon/5/")
        ]
    }

    static func stub2() -> PokemonListResponse {
        PokemonListResponse(next: "https://pokeapi.co/api/v2/pokemon?offset=10&limit=5",
                            results: [
                                PokemonListResponseItem(name: "charizard", url: "https://pokeapi.co/api/v2/pokemon/6/"),
                                PokemonListResponseItem(name: "squirtle", url: "https://pokeapi.co/api/v2/pokemon/7/"),
                                PokemonListResponseItem(name: "wartortle", url: "https://pokeapi.co/api/v2/pokemon/8/"),
                                PokemonListResponseItem(name: "blastoise", url: "https://pokeapi.co/api/v2/pokemon/9/"),
                                PokemonListResponseItem(name: "caterpie", url: "https://pokeapi.co/api/v2/pokemon/10/")
                            ])
    }

    static func stub2PokemonListItems() -> [PokemonListItem] {
        [
            PokemonListItem(name: "Charizard", detailsUrl: "https://pokeapi.co/api/v2/pokemon/6/"),
            PokemonListItem(name: "Squirtle", detailsUrl: "https://pokeapi.co/api/v2/pokemon/7/"),
            PokemonListItem(name: "Wartortle", detailsUrl: "https://pokeapi.co/api/v2/pokemon/8/"),
            PokemonListItem(name: "Blastoise", detailsUrl: "https://pokeapi.co/api/v2/pokemon/9/"),
            PokemonListItem(name: "Caterpie", detailsUrl: "https://pokeapi.co/api/v2/pokemon/10/")
        ]
    }

    static func stub3() -> PokemonListResponse {
        PokemonListResponse(next: nil,
                            results: [
                                PokemonListResponseItem(name: "metapod", url: "https://pokeapi.co/api/v2/pokemon/11/"),
                                PokemonListResponseItem(name: "butterfree", url: "https://pokeapi.co/api/v2/pokemon/12/"),
                                PokemonListResponseItem(name: "weedle", url: "https://pokeapi.co/api/v2/pokemon/13/"),
                                PokemonListResponseItem(name: "kakuna", url: "https://pokeapi.co/api/v2/pokemon/14/"),
                                PokemonListResponseItem(name: "beedrill", url: "https://pokeapi.co/api/v2/pokemon/15/")
                            ])
    }

    static func stub3PokemonListItems() -> [PokemonListItem] {
        [
            PokemonListItem(name: "Metapod", detailsUrl: "https://pokeapi.co/api/v2/pokemon/11/"),
            PokemonListItem(name: "Butterfree", detailsUrl: "https://pokeapi.co/api/v2/pokemon/12/"),
            PokemonListItem(name: "Weedle", detailsUrl: "https://pokeapi.co/api/v2/pokemon/13/"),
            PokemonListItem(name: "Kakuna", detailsUrl: "https://pokeapi.co/api/v2/pokemon/14/"),
            PokemonListItem(name: "Beedrill", detailsUrl: "https://pokeapi.co/api/v2/pokemon/15/")
        ]
    }
}
