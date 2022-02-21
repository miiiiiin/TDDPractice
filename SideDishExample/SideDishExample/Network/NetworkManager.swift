//
//  NetworkManager.swift
//  SideDishExample
//
//  Created by Running Raccoon on 2022/02/21.
//

import Foundation
import RxSwift
import Alamofire

protocol Networkable {
    func get<T: Decodable>(type: T.Type, endpoint: ServerAPI.Endpoint) -> Observable<T>
}

final class NetworkManager: Networkable {
    
    let sessionManager: SessionManagerProtocol
    
    init(sessionManager: SessionManagerProtocol = AF) {
        self.sessionManager = sessionManager
    }
    
    func get<T: Decodable>(type: T.Type, endpoint: ServerAPI.Endpoint) -> Observable<T> {
            
        let url = "\(ServerAPI.baseURL)\(endpoint.path)"
        
        return Observable.create() { [weak self] emitter in // emitter: AnyObserver<T> (ObserverType)
            
            self?.sessionManager.request(url, method: .get,
                                         parameters: nil,
                                         encoding: URLEncoding.default,
                                         headers: nil,
                                         interceptor: nil,
                                         requestModifier: nil)
                .responseDecodable(of: type) { response in
                    guard let statusCode = response.response?.statusCode else {
                        return emitter.onError(NetworkError.internet)
                    }
                    
                    switch statusCode {
                    case 200..<300:
                        guard let result = response.value else {
                            return emitter.onError(NetworkError.noResult)
                        }
                        emitter.onNext(result)
                        emitter.onCompleted()
                        
                    case 300..<400:
                        emitter.onError(NetworkError.redirection)
                    case 400..<500:
                       emitter.onError(NetworkError.notAllowed)
                   case 500...:
                       emitter.onError(NetworkError.server)
                   default:
                       emitter.onError(NetworkError.unknown)
                    }
                }
            
            return Disposables.create()
        }
    }
}
