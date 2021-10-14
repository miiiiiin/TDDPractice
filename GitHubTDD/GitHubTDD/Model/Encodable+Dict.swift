//
//  Encodable+Dict.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/14.
//

import Foundation

extension Encodable {
    
    func getDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw RequestsError.failSerialization
        }
        return dictionary
    }
    
    func getQueryItem() throws -> [URLQueryItem] {
        let dictionary = try getDictionary()
        return dictionary.map {
            URLQueryItem(name: $0, value: String(describing: $1))
        }
    }
}
