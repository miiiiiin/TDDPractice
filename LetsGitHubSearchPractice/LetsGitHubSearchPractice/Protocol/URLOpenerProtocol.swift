//
//  URLOpenerProtocol.swift
//  LetsGitHubSearchPractice
//
//  Created by Running Raccoon on 2021/11/15.
//

import UIKit

protocol URLOpenerProtocol {
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?)
}

extension UIApplication: URLOpenerProtocol {
    
}
