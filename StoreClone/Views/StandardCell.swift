//
//  StandardCell.swift
//  StoreClone
//
//  Created by junwoo on 16/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class StandardCell: UITableViewCell {
  
  static let reuseIdentifier = "StandardCell"
  internal lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  internal lazy var detailLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .right
    return label
  }()
  internal lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    if let _ = titleLabel.text {
      addTitleLabel()
      addDetailLabel()
    } else {
      addDescriptionLabel()
    }
  }
  
  func configure(title: String? = nil,
                 detail: String? = nil,
                 artWork: Artwork? = nil) {
    selectionStyle = .none
    titleLabel.text = title
    detailLabel.text = detail
    descriptionLabel.text = artWork?.description
  }
  
  func addTitleLabel() {
    addSubview(titleLabel)
    titleLabel.topAnchor.constraint(equalTo: topAnchor,
                                    constant: 8).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                        constant: 8).isActive = true
    titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
  }
  
  func addDetailLabel() {
    addSubview(detailLabel)
    detailLabel.topAnchor.constraint(equalTo:
      titleLabel.topAnchor).isActive = true
    detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                          constant: -50).isActive = true
    detailLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
  }
  
  func addDescriptionLabel() {
    addSubview(descriptionLabel)
    descriptionLabel.topAnchor.constraint(equalTo: topAnchor,
                                          constant: 8).isActive = true
    descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                              constant: 50).isActive = true
    descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                               constant: -50).isActive = true
    descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                             constant: -8).isActive = true
  }
}
