//
//  UserDefaultServiceType.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import Foundation

protocol UserDefaultServiceType {
    func value<T>(object: T.Type, forKey key: String) -> T?
    func set<T>(value: T?, forKey key: String)
}

final class UserDefaultService: BaseService, UserDefaultServiceType {
    
    private var defaults: UserDefaults {
        return UserDefaults.standard
    }

    func value<T>(object: T.Type, forKey key: String) -> T? {
        return self.defaults.value(forKey: key) as? T
    }
    
    func set<T>(value: T?, forKey key: String) {
        self.defaults.setValue(value, forKey: key)
//        self.defaults.synchronize()
        
        print("set sync: \(self.defaults.synchronize())")
    }
}
