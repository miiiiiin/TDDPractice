//
//  FirebaseAppStub.swift
//  LetsGitHubSearchPracticeTests
//
//  Created by Running Raccoon on 2021/11/16.
//

@testable import LetsGitHubSearchPractice

final class FirebaseAppStub: FirebaseAppProtocol {
    
    static var configureExecutionCount = 0
    
    static func confiure() {
        configureExecutionCount += 1
    }
}
