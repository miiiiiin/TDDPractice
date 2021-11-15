//
//  AppDependency.swift
//  LetsGitHubSearchPractice
//
//  Created by Running Raccoon on 2021/11/15.
//

import Alamofire

struct AppDependency {
    let repositoryService: RepositoryServiceProtocol
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let sessionManager = Session.default
        let repositoryService = RepositoryService(session: sessionManager)
        
        return AppDependency(repositoryService: repositoryService)
    }
}
