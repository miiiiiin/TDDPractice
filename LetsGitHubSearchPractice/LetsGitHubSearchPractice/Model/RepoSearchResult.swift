//
//  RepoSearchResult.swift
//  LetsGitHubSearchPractice
//
//  Created by Running Raccoon on 2021/11/12.
//

import Foundation

struct RepoSearchResult: Decodable {
    
    let totalCount: Int
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
