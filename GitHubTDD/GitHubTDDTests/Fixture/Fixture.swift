//
//  Fixture.swift
//  GitHubTDDTests
//
//  Created by Running Raccoon on 2021/10/18.
//

import Foundation
@testable import GitHubTDD

struct Fixture {
    struct Repositories {
        static let sample: SearchedRepositories = ResourcesLoader.loadJson("sample")
        static var first: Repository {
            return sample.items.first!
        }
        static let sampleData: Data = ResourcesLoader.readData("sample", ofType: "json")
    }
}
