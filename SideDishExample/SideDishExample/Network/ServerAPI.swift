//
//  ServerAPI.swift
//  SideDishExample
//
//  Created by Running Raccoon on 2022/02/21.
//

import Foundation

struct ServerAPI {
    static let baseURL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan"
    
    enum Endpoint {
        case main
        case soup
        case side
        case detail(String)
        
        var path: String {
            switch self {
            case .detail(let hash): return "/detail/\(hash)"
            default: return "/\(self)"
            }
        }
    }
    
    static var mainCategories: [ServerAPI.Endpoint] {
        return [.main, .soup, .side]
    }
}
