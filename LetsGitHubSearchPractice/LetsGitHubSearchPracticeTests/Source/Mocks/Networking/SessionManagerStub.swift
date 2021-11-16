//
//  SessionManagerStub.swift
//  LetsGitHubSearchPracticeTests
//
//  Created by Running Raccoon on 2021/11/12.
//


@testable import LetsGitHubSearchPractice
@testable import Alamofire

final class SessionManagerStub: SessionManagerProtocol {
    
    var requestParameters: (url: URLConvertible, method: HTTPMethod, parameters: Parameters?)?

    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> DataRequest {
        self.requestParameters = (url, method, parameters)
        return AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
}
