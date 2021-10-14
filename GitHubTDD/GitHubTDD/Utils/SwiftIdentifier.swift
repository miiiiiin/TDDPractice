//
//  SwiftIdentifier.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/13.
//

import Foundation

protocol SwiftIdentifier {
    static var identifier: String { get }
}

extension SwiftIdentifier {    
    static var identifier: String {
        print("identifier: \(Self.self)")
        return String(describing: Self.self)
    }
}
