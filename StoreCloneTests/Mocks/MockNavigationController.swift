//
//  MockNavigationController.swift
//  StoreCloneTests
//
//  Created by junwoo on 16/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class MockNavigationController: UINavigationController {
  var pushedViewController: UIViewController?
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    pushedViewController = viewController
    super.pushViewController(viewController, animated: animated)
  }
}
