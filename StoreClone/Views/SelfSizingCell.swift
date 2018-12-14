//
//  SelfSizingCell.swift
//  StoreClone
//
//  Created by junwoo on 14/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class SelfSizingCell: UITableViewCell {
  
  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
  }
  
  func configure() {
    addSubview(descriptionLabel)
    
  }
}
