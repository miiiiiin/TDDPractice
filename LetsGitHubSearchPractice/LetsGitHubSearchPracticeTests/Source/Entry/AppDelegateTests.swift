//
//  AppDelegateTests.swift
//  LetsGitHubSearchPracticeTests
//
//  Created by Running Raccoon on 2021/11/16.
//

import XCTest
@testable import LetsGitHubSearchPractice

class AppDelegateTests: XCTestCase {
    
    func testDidFinishLaunching_configureFirebaseApp() {
        // given
        let firebaseApp = FirebaseAppStub.self
        firebaseApp.configureExecutionCount = 0
        
        let dependency = AppDependency(
            repositoryService: RepositoryServiceStub(),
            urlOpener: URLOpenerStub(),
            firebaseApp: firebaseApp,
            firebaseAnalytics: FirebaseAnalyticsStub.self)
        
        let appDelegate = AppDelegate(dependency: dependency)
        
        // when
        
        _ = appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        
        // then
        XCTAssertEqual(firebaseApp.configureExecutionCount, 1)
        
    }
}
