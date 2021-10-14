//
//  Data+Decode.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/14.
//

import Foundation
import RxSwift

extension Data {
    func decode<D: Decodable>(_ type: D.Type) throws -> D {
        let object = try JSONDecoder().decode(D.self, from: self)
        return object
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Data {
    public func map<D: Decodable>(_ type: D.Type) -> Single<D> {
        return self.map {
            return try $0.decode(type)
        }
    }
}

