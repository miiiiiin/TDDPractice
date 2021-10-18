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
        let sample: SearchedRepositories = ResourcesLoader.loadJson("sample")
        var first: Repository {
            return sample.items.first!
        }
        let sampleData: Data = ResourcesLoader.readData("sample", ofType: "json")
    }
}
