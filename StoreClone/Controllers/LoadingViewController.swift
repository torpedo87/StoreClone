//
//  LoadingViewController.swift
//  StoreClone
//
//  Created by junwoo on 23/01/2019.
//  Copyright © 2019 samchon. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
  
  private lazy var spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView(style: .gray)
    spinner.translatesAutoresizingMaskIntoConstraints = false
    return spinner
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    spinner.startAnimating()
    view.addSubview(spinner)
    
    NSLayoutConstraint.activate([
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}
