/// Copyright (c) 2022 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
@testable import HalfTunes

class HalfTunesTests: XCTestCase {

  var sut: URLSession!
  
  override func setUp() {
    super.setUp()
    sut = URLSession(configuration: .default)
    
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  
  // Asynchronous test: success / failure
  // iTunes에 valid 한 쿼리를 보내면 200 status 가 오는지 확인하는 코드
  func testValidCallToItunesGetsHTTPStatusCode200() {
    // given
    let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=h")
    
    // 1
    let promise = expectation(description: "Status code: 200")
    
    // when
    
    let dataTask = sut.dataTask(with: url!) { data, response, error in
      // then
      if let error = error {
        XCTFail("Error: \(error.localizedDescription)")
        return
      } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
        if statusCode == 200 {
          
          XCTAssertEqual(statusCode, 200)
          // 2
          promise.fulfill()
        } else {
          XCTFail("Status Code: \(statusCode)")
        }
      }
    }
    dataTask.resume()
    // 3
    wait(for: [promise], timeout: 5)
    
    
    // expectation(description:) : 'promise'에 저장된 XCTestExpectation 객체를 반환한다. 'description'파라미터는 정상동작 했을 때 기대하는 결과에 대한 설명 부분이다.
    
    // promise.fulfill(): 비동기 함수의 completion hanlder에서 호출되는 성공조건 클로저 이다. expectation이 맞을 때 flag 역할을 한다.

    // wait(for:timeout:) : 모든 expectation들이 충족되기 전이나 timeout interval이 끝날 때 까지 계속 테스트를 진행한다.
  }
  

}
