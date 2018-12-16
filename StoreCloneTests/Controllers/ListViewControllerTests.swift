//
//  ListViewControllerTests.swift
//  StoreCloneTests
//
//  Created by junwoo on 16/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import XCTest
@testable import StoreClone

class ListViewControllerTests: XCTestCase {
  var sut: ListViewController!
  
  override func setUp() {
    let session = URLSessionMock()
    session.setMockData()
    let manager = NetworkManager(session: session)
    sut = ListViewController(manager: manager)
    sut.loadViewIfNeeded()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_pushDetailVC_WhenCellClicked() {
    //given
    let mockNavigationController = MockNavigationController(rootViewController: sut)
    UIApplication.shared.keyWindow?.rootViewController = mockNavigationController
    sut.loadViewIfNeeded()
    
    //when
    let indexPath = IndexPath(row: 0, section: 0)
    sut.tableView(sut.tableView, didSelectRowAt: indexPath)
    
    //then
    XCTAssertNotNil(mockNavigationController.pushedViewController)
    XCTAssertTrue(mockNavigationController.pushedViewController is DetailViewController)
  }
  
}
