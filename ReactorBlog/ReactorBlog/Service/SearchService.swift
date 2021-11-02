//
//  SearchService.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import Foundation
import RxSwift

enum FilterType: String {
    case blog = "Blog"
    case cafe = "Cafe"
    case all = "All"
}

protocol SearchServiceType {
    
    func searchPost(query: String, filter: FilterType, page: Int, size: Int) -> Single<SearchResult>
    
    func setSearchHistory(histories: [String])
    
    func getSearchHistory() -> Observable<[String]>
    
    var urlEvent: PublishSubject<[String]> { get }
    
    func isCheckedURL(url: URL) -> Bool
    
    func setCheckedURL(url: URL)
    
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

    let urlEvent = PublishSubject<[String]>()
    
    var readURLs: [String]? {
        return self.provider.userDefaultService.value(object: [String].self, forKey: "readURLs")
    }
    
    var searchHistories: [String]? {
        return self.provider.userDefaultService.value(object: [String].self, forKey: "SearchHistory")
    }
    
    
    func searchBlog(query: String, page: Int, size: Int) -> Single<SearchResult> {
        return self.network.requestObject(.searchBlog(query, page, size), type: SearchResult.self)
    }
    
    func setSearchHistory(histories: [String]) {
        self.provider.userDefaultService.set(value: histories, forKey: "SearchHistory")
    }
    
    func getSearchHistory() -> Observable<[String]> {
        guard let histories = self.searchHistories else { return .empty() }
        return .just(histories)
    }
    
    func searchPost(query: String, filter: FilterType, page: Int, size: Int) -> Single<SearchResult> {
        return searchBlog(query: query, page: page, size: size)
    }
    
    func setCheckedURL(url: URL) {
        var urls = self.readURLs ?? [""]
        urls.append(url.absoluteString)
        
        self.provider.userDefaultService.set(value: Array(Set(urls)), forKey: "readURLs")
        self.urlEvent.onNext(urls)
    }
    
    func isCheckedURL(url: URL) -> Bool {
        let url = url.absoluteString
        let urls = self.readURLs ?? [""]
        return urls.contains(url)
    }
}
