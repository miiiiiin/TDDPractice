//
//  NetworkRequestProtocol.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/14.
//

import Foundation
import RxSwift

protocol NetworkRequestProtocol {
    func request(with: URLRequest) -> Single<Data>
}
