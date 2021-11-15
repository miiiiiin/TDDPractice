//
//  RepositoryServiceStub.swift
//  LetsGitHubSearchPracticeTests
//
//  Created by Running Raccoon on 2021/11/15.
//

@testable import Alamofire
@testable import LetsGitHubSearchPractice

final class RepositoryServiceStub: RepositoryServiceProtocol {
    
    var searchParameters: String?
    
    func search(keyword: String, completionHandler: @escaping (Result<RepoSearchResult, AFError>) -> Void) -> DataRequest {
        self.searchParameters = keyword
        let url: URLConvertible = try! keyword.asURL() as! URLConvertible
        return AF.request(url)
    }

}
