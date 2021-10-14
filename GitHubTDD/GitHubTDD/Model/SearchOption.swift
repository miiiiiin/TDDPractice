//
//  SearchOption.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/14.
//

import Foundation

struct SearchOption: Encodable {
    let query: String
    let sort: String
    let order: String
    
    init(query: String, sort: String = "stars", order: String = "desc") {
        self.query = query
        self.sort = sort
        self.order = order
    }
}
