//
//  BaseAPI.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import Moya

protocol BaseAPI: TargetType {}

extension BaseAPI {
    
    var baseURL: URL {
        URL(string: "https://dapi.kakao.com")!
    }
    
    var method: Method {
        .get
    }
    
//    var sampleData: Data {
//        Data()
//    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        nil
    }
}
