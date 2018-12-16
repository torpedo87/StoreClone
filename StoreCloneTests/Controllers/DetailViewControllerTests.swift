//
//  DetailViewControllerTests.swift
//  StoreCloneTests
//
//  Created by junwoo on 16/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import XCTest
@testable import StoreClone

class DetailViewControllerTests: XCTestCase {
  
  var sut: DetailViewController!
  
  override func setUp() {
    let artWork = Artwork(
      iconImageUrl: "https://is3-ssl.mzstatic.com/image/thumb/Purple118/v4/98/0e/cc/980ecc3e-c70c-8a54-1efb-39ddc8b36c71/source/512x512bb.jpg",
      name: "name",
      artist: "artist",
      genres: ["genre"],
      price: "100",
      rating: 5.0,
      screenshotUrls: [
        "https://is2-ssl.mzstatic.com/image/thumb/Purple128/v4/46/ba/4d/46ba4d77-ad51-2e51-6a8d-d3b7f5501d55/source/392x696bb.jpg",
        "https://is1-ssl.mzstatic.com/image/thumb/Purple118/v4/f3/47/44/f3474481-e2d0-501b-c612-7bdbfa7512db/source/392x696bb.jpg"
      ],
      version: "0.1",
      releaseNotes: "release",
      trackViewUrl: "https://itunes.apple.com/kr/app/%EC%95%84%EC%9D%B4%EB%94%94%EC%96%B4%EC%8A%A4-idus/id872469884?mt=8&uo=4",
      description: "description",
      size: "100",
      age: "10")
    sut = DetailViewController(artwork: artWork)
    sut.loadViewIfNeeded()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_changeCellHeight_WhenMoreInfoButtonTapped() {
    //given
    UIApplication.shared.keyWindow?.rootViewController = sut
    sut.loadViewIfNeeded()
    let expectation = XCTestExpectation(description: "wait for load tableview")
    XCTWaiter().wait(for: [expectation], timeout: 3)
    guard let dynamicCell = sut.tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? DynamicCell else {
      XCTFail("cannot access dynamicCell")
      return
    }
    XCTAssertEqual(dynamicCell.moreInfoLabel.bounds.height, 0)
    
    //when
    dynamicCell.handleExpand(dynamicCell.expandButton)
    
    //then
    let expectationForAnimation = XCTestExpectation(description: "wait for animation")
    XCTWaiter().wait(for: [expectationForAnimation], timeout: 2)
    XCTAssertEqual(dynamicCell.moreInfoLabel.bounds.height, 100)
  }
  
  func test_presentActivityVC_WhenShareButtonTapped() {
    //given
    UIApplication.shared.keyWindow?.rootViewController = sut
    sut.loadViewIfNeeded()
    let expectation = XCTestExpectation(description: "wait for load tableview")
    XCTWaiter().wait(for: [expectation], timeout: 3)
    
    //when
    sut.shareButtonTapped()
    let expectationForPresent = XCTestExpectation(description: "wait for load activityVC")
    XCTWaiter().wait(for: [expectationForPresent], timeout: 3)
    //then
    XCTAssertNotNil(sut.presentedViewController)
    XCTAssertTrue(sut.presentedViewController is UIActivityViewController)
  }
  
  func test_openWeb_WhenWebButtonTapped() {
    //given
    UIApplication.shared.keyWindow?.rootViewController = sut
    sut.loadViewIfNeeded()
    let expectation = XCTestExpectation(description: "wait for load tableview")
    XCTWaiter().wait(for: [expectation], timeout: 3)
    XCTAssertEqual(UIApplication.shared.applicationState.rawValue, 0)
    
    //when
    guard let topCell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TopCell else {
      XCTFail("cannot access topCell")
      return
    }
    topCell.webButtonTapped(topCell.webButton)
    let expectationForPresent = XCTestExpectation(description: "wait for load web")
    XCTWaiter().wait(for: [expectationForPresent], timeout: 3)
    
    //then
    XCTAssertEqual(UIApplication.shared.applicationState.rawValue, 2)
    
  }
}
