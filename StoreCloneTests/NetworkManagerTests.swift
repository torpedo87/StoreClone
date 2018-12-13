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
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testSuccessfulResponse() {
    
    let session = URLSessionMock()
    
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
    
    session.data = data
    let manager = NetworkManager(session: session)
    
    var result: Result<[Artwork], LoadingError>?
    manager.loadData(keyword: "핸드메이드") { result = $0 }
    
    var artworks = [Artwork]()
    do {
      artworks = try (result?.resolve())!
    } catch {
      artworks = []
    }
    
    XCTAssertEqual(artworks.count, 43)
    XCTAssertEqual(artworks.contains { $0.name == "아이디어스(idus)" }, true)
  }
  
}
