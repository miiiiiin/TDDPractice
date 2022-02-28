//
//  JokesAPI.swift
//  WoowaNetworkTest
//
//  Created by Running Raccoon on 2022/02/28.
//

import Foundation
import Moya

enum JokesAPI {
    case randomJokes(_ firstName: String? = nil,
                     _ lastName: String? = nil,
                     _ categories: [String] = [])
}

extension JokesAPI: TargetType {

    var baseURL
    var path

    var task: Task {
        switch self {
        case .randomJokes(let firstName, let lastName, let categories):
            var params: [String: Any?] = [
                "firstName": firstName,
                "lastName": lastName
            ]

            if categories.isEmpty == false {
                params["limitTo"] = "(categories)"
            }

            return .requestParameters(
                parameters),
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers
    var method

    var sampleData: Data {
        switch self {
        case .randomJokes(let firstName, let lastName, let categoris):
            let firstName = firstName ?? "Chuck"
            let lastName = lastName ?? "Norris"

            return Data(
                """
                {
                   "type": "success",
                       "value": {
                       "id": 107,
                       "joke": "(firstName) (lastName) can retrieve anything from /dev/null.",
                       "categories": (categoris)
                   }
                }
                """.utf8
            )
        }
    }
}
