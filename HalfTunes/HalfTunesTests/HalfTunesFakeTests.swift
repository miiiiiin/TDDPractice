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

class HalfTunesFakeTests: XCTestCase {

  var sut: SearchViewController!
  
  
  override func setUp() {
    super.setUp()
    sut = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? SearchViewController
    
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "result", ofType: "json")
    let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
    
    let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
  
    let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
    let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
//    sut.downloadsSession = sessionMock
    
    
  }
  
//  비동기 테스트이기 때문에 stub도 비동기 함수처럼 작성해야 한다.
//  when에서 'searchResults'는 작업이 실행되기 전에 비어있다.
//  3곡에 대한 정보를 담고있는 가짜 JSON 데이터는 viewController의 searchResults 배열에 세개의 항목으로 들어가게 된다.
  func test_UpdateSearchResults_ParsesData() {
    // given
    
    let promise = expectation(description: "Status Code: 200")
    
    // when
    
    XCTAssertEqual(sut.searchResults.count, 0, "searchResults should be empty before the data task runs")
    
    let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
    
    let dataTask = sut.downloadsSession.dataTask(with: url!) { data, response, error in
      // if HTTP request is successful, call updateSearchResults(_:)
      // which parses the response data into Tracks
      if let error = error {
        print(error.localizedDescription)
      } else if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          promise.fulfill()
//          self.sut.updatesearchres
        }
      }

    }
    dataTask.resume()
    
    wait(for: [promise], timeout: 5)
    
    // then
    XCTAssertEqual(sut.searchResults.count, 3, "Didn't parse 3 items from fake response")
  }
  
  
  override func tearDown() {
    sut = nil
    super.tearDown()
    
  }

}
