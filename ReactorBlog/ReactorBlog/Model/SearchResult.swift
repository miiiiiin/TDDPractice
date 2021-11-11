//
//  SearchResult.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import Foundation

struct SearchResult: Codable {
    var documents: [Post]
    var meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case documents
        case meta
    }
}
