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

class MockNetworkRequestProtocol: NetworkRequestProtocol, Cuckoo.ProtocolMock {
    
    typealias MockType = NetworkRequestProtocol
    typealias Stubbing = __StubbingProxy_NetworkRequestProtocol
    typealias Verification = __VerificationProxy_NetworkRequestProtocol
    
    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)
    
    private var __defaultImplStub: NetworkRequestProtocol?
    
    func enableDefaultImplementation(_ stub: NetworkRequestProtocol) {
        self.__defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    
    func request(with: URLRequest) -> Single<Data> {
        // requeset(with: URLRequest -> Single<Data> -> failure case (요청 시 메소드 인식 못함)
        return cuckoo_manager.call("request(with: URLRequest) -> Single<Data>",
                                   parameters: (with),
                                   escapingParameters: (with),
                                   superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                                   defaultCall: __defaultImplStub!.request(with: with))
    }
    
    
    struct __StubbingProxy_NetworkRequestProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        
        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        func request<M1: Cuckoo.Matchable>(with: M1) -> Cuckoo.ProtocolStubFunction<(URLRequest), Single<Data>> where M1.MatchedType == URLRequest {
            let matchers: [Cuckoo.ParameterMatcher<(URLRequest)>] = [wrap(matchable: with) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockNetworkRequestProtocol.self, method: "request(with: URLRequest) -> Single<Data>", parameterMatchers: matchers))
        }
    }
    
    struct __VerificationProxy_NetworkRequestProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
        
        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
                
        @discardableResult
        func request<M1: Cuckoo.Matchable>(with: M1) -> Cuckoo.__DoNotUse<(URLRequest), Single<Data>> where M1.MatchedType == URLRequest {
            let matchers: [Cuckoo.ParameterMatcher<(URLRequest)>] = [wrap(matchable: with) { $0 }]
            return cuckoo_manager.verify("request(with: URLRequest) -> Single<Data>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
    }
}

class NetworkRequestProtocolStub: NetworkRequestProtocol {
    func request(with: URLRequest) -> Single<Data> {
        return DefaultValueRegistry.defaultValue(for: (Single<Data>).self)
    }
}

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
        
//        func search<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(query: M1, sort: M2, order: M3) -> Cuckoo.ProtocolStubFunction<(String, String, String), Single<SearchedRepositories>> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String {
//            let matchers: [Cuckoo.ParameterMatcher<(String, String, String)>] = [wrap(matchable: query) { $0.0 }, wrap(matchable: sort) { $0.1 }, wrap(matchable: order) { $0.2 }]
//            return .init(stub: cuckoo_manager.createStub(for: MockGithubServiceType.self, method: "search(query: String, sort: String, order: String) -> Single<SearchRepositories>", parameterMatchers: matchers))
//        }
        
//        func search<M1: Cuckoo.Matchable>(sortOption: M1) -> Cuckoo.ProtocolStubFunction<(SearchOption), Single<SearchRepositories>> where M1.MatchedType == SearchOption {
//            let matchers: [Cuckoo.ParameterMatcher<(SearchOption)>] = [wrap(matchable: sortOption) { $0 }]
//            return .init(stub: cuckoo_manager.createStub(for: MockGithubServiceType.self, method: "search(sortOption: SortOptions) -> Single<SearchRepositories>", parameterMatchers: matchers))
//        }
        
        // MARK: Stubbing GithubServiceType search protocol function
        // sortOption이 파라미터 이름
        func search<M1: Cuckoo.Matchable>(sortOption: M1) -> Cuckoo.ProtocolStubFunction<(SearchOption), Single<SearchedRepositories>> where M1.MatchedType == SearchOption {
            
            // SearchOption타입의 파라미터 매핑
            let matchers: [Cuckoo.ParameterMatcher<(SearchOption)>] = [wrap(matchable: sortOption, mapping: { $0 })]
            
            return .init(stub: cuckoo_manager.createStub(for: MockGithubServiceType.self, method: "search(sortOption: SearchOption) -> Single<SearchedRepositories>", parameterMatchers: matchers))
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
