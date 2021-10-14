//
//  SearchedRepositories.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/14.
//

import Foundation

struct SearchedRepositories: Decodable, Equatable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [Repository]
}
