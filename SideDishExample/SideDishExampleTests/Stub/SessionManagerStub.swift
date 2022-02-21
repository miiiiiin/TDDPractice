//
//  SessionManagerStub.swift
//  SideDishExampleTests
//
//  Created by Running Raccoon on 2022/02/21.
//

import Foundation
import Alamofire
@testable import SideDishExample
@testable import Alamofire

class DummyRequestDelegate: RequestDelegate {
    var sessionConfiguration: URLSessionConfiguration = .default
    var startImmediately: Bool = false

    func cleanup(after request: Request) {}

    func retryResult(for request: Request, dueTo error: AFError, completion: @escaping (RetryResult) -> Void) {
    }

    func retryRequest(_ request: Request, withDelay timeDelay: TimeInterval?) {
        debugPrint("dummy request: \(request), \(timeDelay)")
    }
}

class SessionManagerStub: SessionManagerProtocol {

    var requestParameters: (url: URLConvertible, method: HTTPMethod)?

    func request(_ convertible: URLConvertible,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 encoding: ParameterEncoding,
                 headers: HTTPHeaders?,
                 interceptor: RequestInterceptor?,
                 requestModifier: ((inout URLRequest) throws -> Void)?) -> DataRequest {

        self.requestParameters = (convertible, method)

        let delegate = DummyRequestDelegate()
        let request = URLRequest(url: URL(string: "https://www.google.com")!)

        debugPrint("dummy req delegate: \(delegate)")


        return DataRequest.init(id: UUID(), convertible: request, underlyingQueue: DispatchQueue.global(), serializationQueue: DispatchQueue.main, eventMonitor: nil, interceptor: nil, delegate: delegate)
    }
}
