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
    private let scheduler: RxSchedulerType
    
    init(networkRequest: NetworkRequestProtocol, scheduler: RxSchedulerType) {
        self.networkRequest = networkRequest
        self.scheduler = scheduler
    }
    
    convenience init(scheduler: RxSchedulerType) {
        self.init(networkRequest: NetworkRequest.shared, scheduler: scheduler)
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
