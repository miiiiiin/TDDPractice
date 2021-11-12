//
//  RepositoryService.swift
//  LetsGitHubSearchPractice
//
//  Created by Running Raccoon on 2021/11/12.
//

import Alamofire

final class RepositoryService {    
    class func search(keyword: String, completionHandler: @escaping (Result<RepoSearchResult, AFError>) -> Void) -> DataRequest {
        let url = "https://api.github.com/search/repositories"
        let parameters: Parameters = ["q": keyword]
        
        return Session.default.request(url, method: .get, parameters: parameters, encoding: URLEncoding(), headers: nil)
            .responseData { response in
                let decoder = JSONDecoder()
                let result = response.result.flatMap { data -> Result<RepoSearchResult, AFError> in
                    guard let searchResult = try? decoder.decode(RepoSearchResult.self, from: data) else { return .failure(response.error!) }
                    let result: Result<RepoSearchResult, AFError> = Result<RepoSearchResult, AFError>.success(searchResult)
                    return result
                }
                completionHandler(result)
            }
    }
}
