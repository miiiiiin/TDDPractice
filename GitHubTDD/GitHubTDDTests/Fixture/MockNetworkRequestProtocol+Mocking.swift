//
//  MockNetworkRequestProtocol+Mocking.swift
//  GitHubTDDTests
//
//  Created by Running Raccoon on 2021/10/22.
//

import Foundation
import Cuckoo
import RxSwift
@testable import GitHubTDD

extension MockNetworkRequestProtocol {
    @discardableResult
    func setMocking(data: Data? = nil, error: Error? = nil) {
        stub(self, block: { mock in
            let mockData = data ?? Fixture.Repositories.sampleData
            
            print("check mock stub: \(mock)")
            when(mock.request(with: any()))
                .then { _ in
                    Single.just(mockData)
                        .map {
                            if let error = error {
                                throw error
                            } else {
                                return $0
                            }
                        }
                }
        })
    }
}

extension MockGithubServiceType {
    
    // search protocol function 확인
    @discardableResult
    func setMocking(data: SearchedRepositories? = nil, error: Error? = nil) -> (SearchedRepositories, Error?) {
        let mockData = data ?? Fixture.Repositories.sample
        stub(self, block: { mock in
            when(mock.search(sortOption: any()))
                .then { _ in
                    Single.just(mockData)
                        .map {
                            if let error = error {
                                throw error
                            } else {
                                return $0
                            }
                        }
                }
        })
        
        return (mockData, error)
    }
}
