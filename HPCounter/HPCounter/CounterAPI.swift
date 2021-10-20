//
//  CounterAPI.swift
//  HPCounter
//
//  Created by Running Raccoon on 2021/10/20.
//

import Foundation
import Moya

struct CounterAPI: TargetType {
    var baseURL: URL {
        URL(string: "[https://swift.org](https://swift.org)")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        "}".data(using: .utf8)!
    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        nil
    }
}

// create Mock moyaProvider Sample Response

extension Endpoint {
    class func succeedEndpointClosure<T: TargetType, E: Encodable>(_ targetType: T.Type, with object: E) -> (T) -> Endpoint {
        return { (target: T) -> Endpoint in
            let data = try! JSONEncoder().encode(object)
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: {
                                .networkResponse(200, data)
                            }, method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
    }
    
}
