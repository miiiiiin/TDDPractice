//
//  KakaoAPI.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import Moya

enum KakaoAPI {
    case searchBlog(_ query: String, _ page: Int, _ size: Int)
    case searchCafe(_ query: String, _ page: Int, _ size: Int)
}

extension KakaoAPI: BaseAPI {
    
    var path: String {
        switch self {
        case .searchBlog:
            return "/v2/search/blog"
            
        case .searchCafe:
            return "/v2/search/cafe"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var headers: [String : String]? {
        ["Authorization": "KakaoAK 748e5d544b7c32a9b2b1a4b1a515edd6"]
    }
    
    var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
        
        return .requestPlain
    }
    
    var parameters: [String: Any]? {
        switch self {
        case let .searchBlog(query ,page, size):
            return [
                "query": query,
                "page": page,
                "size": size
            ]
            
        case let .searchCafe(query, page, size):
            return [
                "query": query,
                "page": page,
                "size": size
            ]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.queryString
    }
    
    var sampleData: Data {
        switch self {
        case .searchBlog:
            return Bundle.jsonData(name: "BlogPosts")
            
        case .searchCafe:
            return Bundle.jsonData(name: "CafePosts")
        }
    }
}
