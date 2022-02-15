//
//  RepositoryViewModel.swift
//  RepoSearchTDD
//
//  Created by Running Raccoon on 2022/02/15.
//

import Foundation

class RepositoryViewModel {
    let name: String
    let description: String
    let starsCountText: String
    let url: URL

    init(repository: Repository) {
        self.name = repository.fullName
        self.description = repository.description
        self.starsCountText = "⭐️ \(repository.starsCount)"
        self.url = URL(string: repository.url)!
    }
}
