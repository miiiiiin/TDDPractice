//
//  Post.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import Foundation

struct Post: Codable {
    var blogName: String?
    var contents: String?
    var dateTime: Date?
    var thumbnail: String?
    var title: String?
    var url: URL?
    
    enum CodingKeys: String, CodingKey {
        case blogName = "blogname"
        case dateTime = "datetime"
    }
        
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//    }
}
