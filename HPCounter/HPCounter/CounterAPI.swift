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
