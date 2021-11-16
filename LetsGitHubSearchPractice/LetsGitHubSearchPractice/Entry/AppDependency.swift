//
//  AppDependency.swift
//  LetsGitHubSearchPractice
//
//  Created by Running Raccoon on 2021/11/15.
//

import Alamofire
import Firebase

struct AppDependency {
    let repositoryService: RepositoryServiceProtocol
    let urlOpener: URLOpenerProtocol
    let firebaseApp: FirebaseAppProtocol.Type
    let firebaseAnalytics: FirebaseAnalyticsProtocol.Type
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let sessionManager = Session.default
        let repositoryService = RepositoryService(session: sessionManager)
        let urlOpener = UIApplication.shared
        
        return AppDependency(repositoryService: repositoryService, urlOpener: urlOpener, firebaseApp: FirebaseApp.self, firebaseAnalytics: Firebase.Analytics.self)
    }
}
