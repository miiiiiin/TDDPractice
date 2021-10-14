//
//  GithubService.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/14.
//

import Foundation
import RxSwift

class GithubService: GithubServiceType {
    
    static let BASE_URL = "https://api.github.com/"
    let timeoutInterval = 5.0
    private let networkRequest: NetworkRequestProtocol
    
    init(networkRequest: NetworkRequestProtocol) {
        self.networkRequest = networkRequest
    }
    
    convenience init() {
        self.init(networkRequest: NetworkRequest.shared)
    }
    
    func search(sortOption: SearchOption) -> Single<SearchedRepositories> {
        let path = "/search/repositories"
        return Single.deferred {
            var urlRequest: URLRequest

            urlRequest = try URLRequestBuilder
                .get(baseURL: GithubService.BASE_URL)
                .path(path)
                .queryItems(sortOption.getQueryItem())
                .build()
            
            urlRequest.addValue("", forHTTPHeaderField: "User-Agent")
            
//            return self.networkRequest.request(with: urlRequest)
//                .map(SearchedRepositories.self)
            
            return self.networkRequest.request(with: urlRequest)
                .map(SearchedRepositories.self)
            
        }
    }
}
