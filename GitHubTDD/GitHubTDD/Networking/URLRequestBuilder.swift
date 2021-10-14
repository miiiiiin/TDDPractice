//
//  URLRequestBuilder.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/14.
//

import Foundation

class URLRequestBuilder {
    
    static let DEFAULT_TIMEOUT_SECOND: TimeInterval = 5.0
    
    static func get(baseURL: String) -> GetBuilder {
        return GetBuilder(baseURL: baseURL)
    }
    
    class GetBuilder {
        
        var urlComponent: URLComponents?
        
        internal init(baseURL: String) {
            urlComponent = URLComponents(string: baseURL)
            print("interal urlcomponent: \(urlComponent)")
        }
        
        func path(_ path: String) -> GetBuilder {
            self.urlComponent?.path = path
            return self
        }
        
        func queryItems(_ queryItems: [URLQueryItem]) -> GetBuilder {
            self.urlComponent?.queryItems = queryItems
            return self
        }
        
        func build(timeOut: TimeInterval = DEFAULT_TIMEOUT_SECOND, cachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringLocalCacheData) throws -> URLRequest{
            guard let url = urlComponent?.url else { throw RequestsError.RequestErrorReason.malformURL(url: urlComponent?.url) }
            var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeOut)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
    }
}
