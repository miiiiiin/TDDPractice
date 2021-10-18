//
//  ResourcesLoader.swift
//  GitHubTDDTests
//
//  Created by Running Raccoon on 2021/10/18.
//

import Foundation
@testable import GitHubTDD

class ResourcesLoader {
    
    static func loadJson<T: Decodable>(_ resource: String) -> T {
        let testBundle = Bundle(for: self) // static func (타입)
        if let path = testBundle.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                return error as! T
            }
        }
        
        fatalError("can't decode to \(T.self)")
    }
    
    static func readData(_ resource: String, ofType ext: String) -> Data {
        let testBundle = Bundle(for: self)
        if let path = testBundle.path(forResource: resource, ofType: ext) {
            do {
                return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            } catch {
                
            }
        }
        fatalError("can't read data")
    }
}
