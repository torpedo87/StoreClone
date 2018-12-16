//
//  URLSessionMock.swift
//  StoreCloneTests
//
//  Created by junwoo on 13/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import Foundation

class URLSessionMock: URLSession {
  
  typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
  var data: Data?
  var error: Error?
  
  override func dataTask(with url: URL,
                         completionHandler: @escaping CompletionHandler) -> URLSessionDataTaskMock {
    
    let data = self.data
    let error = self.error
    return URLSessionDataTaskMock {
      completionHandler(data, nil, error)
    }
  }
  
  func setMockData() {
    let testBundle = Bundle(for: NetworkManagerTests.self)
    var data = Data()
    if let fileUrl = testBundle.url(forResource: "raw", withExtension: "txt") {
      do {
        data = try Data(contentsOf: fileUrl)
      } catch {
        fatalError("fetch mock data failed")
      }
    }
    self.data = data
  }
}
