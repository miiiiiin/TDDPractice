//
//  StubServiceProvider.swift
//  ReactorBlogTests
//
//  Created by Running Raccoon on 2021/11/05.
//


@testable import ReactorBlog

final class StubServiceProvider: ServiceProviderType {
    lazy var userDefaultService: UserDefaultServiceType = StubUserDefaultService()
    lazy var searchService: SearchServiceType = SearchService(provider: self, isStub: true)
}
