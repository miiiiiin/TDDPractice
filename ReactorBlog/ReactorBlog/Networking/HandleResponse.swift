//
//  HandleResponse.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import Moya
import RxSwift

// 서버 오류 파싱
extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func handleResponse() -> Single<Element> {
        return flatMap { response in
            if (200...299) ~= response.statusCode {
                return Single.just(response)
            }
            
            if let error = try? response.map(ErrorResponse.self) {
                return Single.error(error)
            }
            
            let genericError = ErrorResponse(errorType: "알 수 없는 에러", message: "")
            return Single.error(genericError)
        }
    }
}
