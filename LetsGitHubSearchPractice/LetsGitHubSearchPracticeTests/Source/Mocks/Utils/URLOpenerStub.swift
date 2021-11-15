//
//  URLOpenerStub.swift
//  LetsGitHubSearchPracticeTests
//
//  Created by Running Raccoon on 2021/11/15.
//

import UIKit

@testable import LetsGitHubSearchPractice

final class URLOpenerStub: URLOpenerProtocol {
    
    var openParameters: URL?
    
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?) {
        self.openParameters = url
    }
}
