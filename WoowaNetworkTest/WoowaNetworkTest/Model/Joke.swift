//
//  Joke.swift
//  WoowaNetworkTest
//
//  Created by Running Raccoon on 2022/02/28.
//

import Foundation

struct JokeReponse: Decodable {
    let type: String
    let value: Joke
}

struct Joke: Decodable {
    let id: Int
    let joke: String
    let categories: [String]
}
