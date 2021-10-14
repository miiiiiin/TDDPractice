//
//  Repository.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/14.
//

import Foundation

struct Repository: Decodable, Equatable {
    let id: UInt64
    let name: String
    let full_name: String
    let owner: Owner
    let description: String
    let url: String
    let stargazers_count: Int
    let forks_count: Int
    let watchers_count: Int
    let open_issues_count: Int
    let score: Float
}

struct Owner: Decodable, Equatable {
    let id: UInt64
    let login: String
    let avatar_url: String
    let url: String
}

//extension Repository: IdentifiableType {
//    var identity: UInt64 {
//        return id
//    }
//}
