//
//  SearchService.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import Foundation
import RxSwift

enum FilterType {
    case blog
    case cafe
    case all
}

protocol SearchServiceType {
    
    func searchPost(query: String, filter: FilterType, page: Int, size: Int) -> Single<SearchResult>
    
    func isCheckedURL(url: URL) -> Bool
}

final class SearchService: BaseService, SearchServiceType {
    
    private var network: Networking<KakaoAPI>
    
    init(provider: ServiceProviderType, isStub: Bool) {
        self.network = Networking(plugins: [], isStub: false) // fixme
        super.init(provider: provider)
    }
    
    override convenience init(provider: ServiceProviderType) {
        self.init(provider: provider, isStub: false)
    }

    
    func searchBlog(query: String, page: Int, size: Int) -> Single<SearchResult> {
        return self.network.requestObject(.searchBlog(query, page, size), type: SearchResult.self)
    }
    
    var readURLs: [String]? {
        return self.provider.userDefaultService.value(object: [String].self, forKey: "readURLs")
    }
    
    func searchPost(query: String, filter: FilterType, page: Int, size: Int) -> Single<SearchResult> {
        return searchBlog(query: query, page: page, size: size)
    }
    
    func isCheckedURL(url: URL) -> Bool {
        let url = url.absoluteString
        let urls = self.readURLs ?? [""]
        return urls.contains(url)
    }
}
