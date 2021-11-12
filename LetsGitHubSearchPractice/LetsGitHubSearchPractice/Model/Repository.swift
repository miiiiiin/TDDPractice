//
//  Repository.swift
//  LetsGitHubSearchPractice
//
//  Created by Running Raccoon on 2021/11/12.
//

import Foundation

struct Repository: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}
