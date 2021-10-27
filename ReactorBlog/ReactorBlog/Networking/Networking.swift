//
//  Networking.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import Moya
import RxSwift

class Networking<API: TargetType>: MoyaProvider<API> {
    
    init(plugins: [PluginType] = [], isStub: Bool) {
        let session = MoyaProvider<API>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 10

        if isStub {
            super.init(stubClosure: Self.immediatelyStub, session: session, plugins: plugins)
        } else {
            super.init(session: session, plugins: plugins)
        }
    }

    func request(_ api: API) -> Single<Response> {
        return rx.request(api)
//            .handleResponse() // fixme
            .filterSuccessfulStatusCodes()
    }
}

extension Networking {
    
    func requestObject<T: Codable>(_ target: API, type: T.Type) -> Single<T> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.iso8601Full)
        return request(target)
            .map(T.self, using: decoder)
            .debug("List")
    }
}
