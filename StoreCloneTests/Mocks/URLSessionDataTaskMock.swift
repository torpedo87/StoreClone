//
//  URLSessionDataTaskMock.swift
//  StoreCloneTests
//
//  Created by junwoo on 13/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import Foundation
@testable import StoreClone

class URLSessionDataTaskMock: URLSessionDataTask {
  private let closure: () -> Void
  
  init(closure: @escaping () -> Void) {
    self.closure = closure
  }
  
  override func resume() {
    closure()
  }
}

