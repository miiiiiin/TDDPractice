//
//  AuthClient.swift
//  ClassCoordinatorExample
//
//  Created by Running Raccoon on 2022/02/15.
//

//import Foundation
//import OAuthSwift
//
///// Wrapper around OAuthSwiftClient to make it testable
//protocol AuthClientProtocol {
//    var credential: OAuthSwiftCredential { get }
//
//    func request(_ url: URLConvertible, method: OAuthSwiftHTTPRequest.Method, parameters: OAuthSwift.Parameters,
//                 headers: OAuthSwift.Headers?, body: Data?, completionHandler: OAuthSwiftHTTPRequest.CompletionHandler?) -> OAuthSwiftRequestHandle?
//}
//
//final class AuthClient: AuthClientProtocol {
//    var credential: OAuthSwiftCredential
//
//    private let client: OAuthSwiftClient
//
//    init(client: OAuthSwiftClient) {
//        self.client = client
//        credential = client.credential
//    }
//
//    @discardableResult
//    func request(_ url: URLConvertible, method: OAuthSwiftHTTPRequest.Method, parameters: OAuthSwift.Parameters = [:],
//                 headers: OAuthSwift.Headers? = nil, body: Data? = nil, completionHandler: OAuthSwiftHTTPRequest.CompletionHandler?) -> OAuthSwiftRequestHandle?
//    {
//        return client.request(url, method: method, parameters: parameters, headers: headers, body: body, completionHandler: completionHandler)
//    }
//}
