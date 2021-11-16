//
//  FirebaseAnalyticsProtocol.swift
//  LetsGitHubSearchPractice
//
//  Created by Running Raccoon on 2021/11/16.
//

import Firebase

protocol FirebaseAnalyticsProtocol {
    static func logEvent(_ name: String, parameters: [String : Any]?)
}

extension Firebase.Analytics: FirebaseAnalyticsProtocol {
    
}

