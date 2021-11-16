//
//  FirebaseAnalyticsStub.swift
//  LetsGitHubSearchPracticeTests
//
//  Created by Running Raccoon on 2021/11/16.
//

@testable import LetsGitHubSearchPractice

final class FirebaseAnalyticsStub: FirebaseAnalyticsProtocol {
    
    static var logEventParameters: (name: String, parameters: [String : Any]?)?
    
    static func logEvent(_ name: String, parameters: [String : Any]?) {
        self.logEventParameters = (name, parameters)
    }    
}
