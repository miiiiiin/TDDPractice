//
//  ServiceProviderType.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import Foundation

protocol ServiceProviderType: AnyObject {
    var userDefaultService: UserDefaultServiceType { get }
    var searchService: SearchServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var userDefaultService: UserDefaultServiceType = UserDefaultService(provider: self)
    lazy var searchService: SearchServiceType = SearchService(provider: self)
}
