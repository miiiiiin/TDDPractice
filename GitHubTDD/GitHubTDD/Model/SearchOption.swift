//
//  SearchOption.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/14.
//

import Foundation

struct SearchOption: Encodable {
    let q: String
    let sort: String
    let order: String
    
    init(q: String, sort: String = "stars", order: String = "desc") {
        self.q = q
        self.sort = sort
        self.order = order
    }
}
