//
//  GithubServic.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/14.
//

import Foundation
import RxSwift

class GithubServic: GithubServiceType {
    
    static let BASE_URL = "https://api.github.com/"
    let timeoutInterval = 5.0
    
    
    func search(sortOption: SearchOption) -> Single<SearchedRepositories> {
        let path = "/search/repositories"
//        return Single.deferred {
//            var urlRequest: URLRequest
//
////            urlRequest = try URLSession.shared.dataTask(with: )
//        }
        
//        return Single
    }
    
}
