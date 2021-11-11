//
//  ErrorResponse.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import Foundation

struct ErrorResponse: Decodable, Error {
    
    var errorType: String
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case errorType
        case message
    }
}
