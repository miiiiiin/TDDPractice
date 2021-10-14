//
//  NetworkRequest.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/14.
//

import Foundation
import RxSwift

class NetworkRequest: NetworkRequestProtocol {
    
    static let shared = NetworkRequest()
    private let session = URLSession.shared
    
    private init() {} // 외부 초기화 방지
    
    func request(with: URLRequest) -> Single<Data> {
        return Single.create { [weak session] single in
            HTTPLog.log(request: with)
            guard let session = session else { return Disposables.create() }
            
            let task = session.dataTask(with: with) { data, response, error in
                defer {
                    print("nework defers")
                    HTTPLog.log(data: data, response: response, error: error) }
                guard let data = data, let response = response else {
                    return
                }
                
                guard let httpRepsonse = response as? HTTPURLResponse else { return }
                
                if 200..<300 ~= httpRepsonse.statusCode {
                    single(.success(data))
                }
            }
            task.resume()
            return Disposables.create(with: task.cancel)
        }
    }
}
