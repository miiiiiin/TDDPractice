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
    
    var languageListReturnValue: Observable<[String]> = .empty()
    override func getLanguageList() -> Observable<[String]> {
        return languageListReturnValue
    }

    override func getMostPopularRepositories(byLanguage language: String) -> Observable<[Repository]> {
        debugPrint("getmost populoar mock: \(language)")
        repositoriesLanguageArgument = language
        return repositoriesReturnValue
    }
}
