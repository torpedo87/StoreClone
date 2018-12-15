//
//  SelfSizingCell.swift
//  StoreClone
//
//  Created by junwoo on 14/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class SelfSizingCell: UITableViewCell {
  
  static let reuseIdentifier = "SelfSizingCell"
  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
    descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
    descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
    descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
  }
  
  func configure(artwork: Artwork) {
    addSubview(descriptionLabel)
    descriptionLabel.text = artwork.description
  }
}
