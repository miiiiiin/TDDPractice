//
//  SessionManagerProtocol.swift
//  SideDishExample
//
//  Created by Running Raccoon on 2022/02/21.
//

import Foundation
import Alamofire

protocol SessionManagerProtocol {
    func request(_ convertible: URLConvertible,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 encoding: ParameterEncoding,
                 headers: HTTPHeaders?,
                 interceptor: RequestInterceptor?,
                 requestModifier: ((inout URLRequest) throws -> Void)?) -> DataRequest    
}


extension Session: SessionManagerProtocol {
    
}
