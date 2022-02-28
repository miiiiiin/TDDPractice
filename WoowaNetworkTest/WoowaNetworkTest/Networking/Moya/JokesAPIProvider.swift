//
//  JokesAPIProvider.swift
//  WoowaNetworkTest
//
//  Created by Running Raccoon on 2022/02/28.
//

import Foundation
import Moya

//class JokesAPIProvider {
//
//    let provider: MoyaProvider<JokesAPI>
//    init(provider: MoyaProvider<JokesAPI> = .init()) {
//        self.provider = provider
//    }
//
//    func fetchRandomJoke(firstName: String? = nil,
//                         lastName: String? = nil,
//                         categories: [String] = [],
//                         completion: @escaping (Result<Joke, Error>) -> Void) {
//        provider.request(.randomJokes(firstName, lastName, categories)) { result in
//            switch result {
//            case .success(let moyaResponse):
//                completion(.success(try! moyaResponse.map(JokeReponse.self).value))
//            case .failure(let moyaError):
//                completion(.failure(moyaError))
//            }
//        }
//    }
//}

class JokesAPIProvider: ProviderProtocol {

    typealias T = JokesAPI
    var provider: MoyaProvider<JokesAPI>

    required init(isStub: Bool = false, sampleStatusCode: Int = 200, customEndpointClosure: ((T) -> Endpoint)? = nil) {
        provider = Self.consProvider(isStub, sampleStatusCode, customEndpointClosure)
    }

    func fetchRandomJoke(firstName: String? = nil, lastName: String? = nil, categories: [String] = []) -> Single<Joke> {
        return request(type: Joke.self, atKeyPath: "value", target: .randomJokes(firstName, lastName, categories))
    }
}
