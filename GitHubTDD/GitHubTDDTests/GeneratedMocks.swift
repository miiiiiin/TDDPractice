//
//  GeneratedMocks.swift
//  GitHubTDDTests
//
//  Created by Running Raccoon on 2021/10/21.
//

import Foundation
import RxSwift
import Cuckoo
@testable import GitHubTDD

class MockGithubServiceType: GithubServiceType, Cuckoo.ProtocolMock {
    
    typealias MocksType = GithubServiceType
    typealias Stubbing = __StubbingProxy_GithubServiceType
    typealias Verification = __VerificationProxy_GithubServiceType
    
    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)
 
    
    private var __defaultImplStub: GithubServiceType?
    
    
    func enableDefaultImplementation(_ stub: GithubServiceType) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    
    func search(sortOption: SearchOption) -> Single<SearchedRepositories> {
        return cuckoo_manager.call("search(sortOption: SearchOption) -> Single<SearchedRepositories>", parameters: (sortOption), escapingParameters: (sortOption), superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(), defaultCall: __defaultImplStub?.search(sortOption: sortOption)) as! Single<SearchedRepositories>
    }
    
    struct __StubbingProxy_GithubServiceType: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        
        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        func search<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(query: M1, sort: M2, order: M3) -> Cuckoo.ProtocolStubFunction<(String, String, String), Single<SearchedRepositories>> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String, String)>] = [wrap(matchable: query) { $0.0 }, wrap(matchable: sort) { $0.1 }, wrap(matchable: order) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockGithubServiceType.self, method: "search(query: String, sort: String, order: String) -> Single<SearchRepositories>", parameterMatchers: matchers))
        }
    }
    
    struct __VerificationProxy_GithubServiceType: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        @discardableResult
        func search<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(query: M1, sort: M2, order: M3) -> Cuckoo.__DoNotUse<(String, String, String), Single<SearchedRepositories>> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String, String)>] = [wrap(matchable: query) { $0.0 }, wrap(matchable: sort) { $0.1 }, wrap(matchable: order) { $0.2 }]
            return cuckoo_manager.verify("search(query: String, sort: String, order: String) -> Single<SearchRepositories>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
    }
}

class GithubServiceTypeStub: GithubServiceType {
    func search(sortOption: SearchOption) -> Single<SearchedRepositories> {
        return DefaultValueRegistry.defaultValue(for: Single<SearchedRepositories>.self)
    }
}
