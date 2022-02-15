//
//  GithubServiceMock.swift
//  RepoSearchTDDTests
//
//  Created by Running Raccoon on 2022/02/15.
//

@testable import RepoSearchTDD
import RxSwift

class GithubServiceMock: GithubService {
    
    var repositoriesLanguageArgument: String!
    var repositoriesReturnValue: Observable<[Repository]> = .empty()
    
    override func getMostPopularRepositories(byLanguage language: String) -> Observable<[Repository]> {
        repositoriesLanguageArgument = language
        return repositoriesReturnValue
    }
}
