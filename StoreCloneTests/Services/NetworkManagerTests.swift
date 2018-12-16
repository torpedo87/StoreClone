//
//  NetworkManagerTests.swift
//  StoreCloneTests
//
//  Created by junwoo on 13/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import XCTest
@testable import StoreClone

class NetworkManagerTests: XCTestCase {
  
  var session: URLSessionMock!
  var manager: NetworkManager!
  
  override func setUp() {
    session = URLSessionMock()
    manager = NetworkManager(session: session)
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_loadData() {
    
    let data = Data(bytes: [0, 1, 0, 1])
    session.data = data
    var result: Result<Data, LoadingError>?
    let url = URL(fileURLWithPath: "url")
    manager.loadData(url: url) { result = $0 }
    var resultData: Data?
    do {
      resultData = try result?.resolve()
    } catch {
      XCTFail("result resolve fail")
    }
    
    XCTAssertEqual(resultData, data)
  }
  
  func test_convertDataToArtworks() {
    let testBundle = Bundle(for: NetworkManagerTests.self)
    var data = Data()
    if let fileUrl = testBundle.url(forResource: "raw", withExtension: "txt") {
      do {
        data = try Data(contentsOf: fileUrl)
      } catch {
        XCTFail("contents could not be loaded!")
      }
    } else {
      XCTFail("example.txt not found!")
    }
    
    let artworks = manager.convertDataToArtworks(data: data)
    XCTAssertEqual(artworks.count, 43)
    XCTAssertTrue(artworks.contains { $0.name == "아이디어스(idus)" })
  }
  
}
