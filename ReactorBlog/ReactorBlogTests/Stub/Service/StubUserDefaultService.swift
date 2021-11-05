//
//  StubUserDefaultService.swift
//  ReactorBlogTests
//
//  Created by Running Raccoon on 2021/11/05.
//

@testable import ReactorBlog

class StubUserDefaultService: UserDefaultServiceType {
    
    var store = [String: Any]()
    
    func value<T>(object: T.Type, forKey key: String) -> T? {
        return self.store[key] as? T
    }
    
    func set<T>(value: T?, forKey key: String) {
        print("userdfeault stub: \(value), \(key)")
        if let value = value {
            self.store[key] = value
            print("stub store: \(self.store[key])")
        } else {
            self.store.removeValue(forKey: key)
        }
    }
}
