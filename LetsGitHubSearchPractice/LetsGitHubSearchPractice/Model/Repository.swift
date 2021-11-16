//
//  Repository.swift
//  LetsGitHubSearchPractice
//
//  Created by Running Raccoon on 2021/11/12.
//

import Foundation

struct Repository: Decodable {
    let name: String
    let fullName: String
    let stargazersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
    }
}
