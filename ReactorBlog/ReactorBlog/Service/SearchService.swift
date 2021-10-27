//
//  SearchService.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import Foundation
import RxSwift

protocol SearchServiceType {
    
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

    var readURLs: [String]? {
        return self.provider.userDefaultService.value(object: [String].self, forKey: "readURLs")
    }
    
    func isCheckedURL(url: URL) -> Bool {
        let url = url.absoluteString
        let urls = self.readURLs ?? [""]
        return urls.contains(url)
    }
}
