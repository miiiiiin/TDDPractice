//
//  AppDependency.swift
//  LetsGitHubSearchPractice
//
//  Created by Running Raccoon on 2021/11/15.
//

import Alamofire
import Firebase

struct AppDependency {
//    let repositoryService: RepositoryServiceProtocol
//    let urlOpener: URLOpenerProtocol
//    let firebaseAnalytics: FirebaseAnalyticsProtocol.Type
    let firebaseApp: FirebaseAppProtocol.Type
    let searchRepositoryVCDependency: SearchRepositoryViewController.Dependency
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let sessionManager = Session.default
        let repositoryService = RepositoryService(session: sessionManager)
        let urlOpener = UIApplication.shared
        
        return AppDependency(firebaseApp: FirebaseApp.self,
                             searchRepositoryVCDependency: .init(repositoryService: repositoryService,
                                                                 urlOpener: urlOpener,
                                                                 firebaseAnalytics: Firebase.Analytics.self))
    }
}
