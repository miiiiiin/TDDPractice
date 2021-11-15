//
//  SessionManagerProtocol.swift
//  LetsGitHubSearchPractice
//
//  Created by Running Raccoon on 2021/11/12.
//

import Alamofire

protocol SessionManagerProtocol {
    @discardableResult
    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> DataRequest
}

extension Session: SessionManagerProtocol {
    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> DataRequest {
        return AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
    
}
