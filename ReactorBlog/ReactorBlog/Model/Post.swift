//
//  Post.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import Foundation

enum PostKind: String {
    case blog = "Blog"
    case cafe = "Cafe"
}

struct Post: Codable, Equatable {
    var blogName: String?
    var contents: String?
    var dateTime: Date
    var thumbnail: URL?
    var title: String
    var url: URL
    
    enum CodingKeys: String, CodingKey {
        case blogName = "blogname"
        case contents
        case dateTime = "datetime"
        case thumbnail
        case title
        case url
    }
    
    var name: String {
//        if let name = cafeName {
//            return name
//        } else if let name = blogName {
            return name
//        } else {
//            return ""
//        }
    }
    
    var kind: PostKind {
//        if cafeName != nil {
//            return .cafe
//        } else {
            return .blog
//        }
    }
        
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        blogName = try? values.decode(String.self, forKey: .blogName)
        contents = try? values.decode(String.self, forKey: .contents)
        dateTime = try values.decode(Date.self, forKey: .dateTime)
        thumbnail = try? values.decode(URL.self, forKey: .thumbnail)
        title = try values.decode(String.self, forKey: .title)
        url = try values.decode(URL.self, forKey: .url)
    }
}
