//
//  NormalCell.swift
//  StoreClone
//
//  Created by junwoo on 15/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class StandardCell: UITableViewCell {
  
  static let reuseIdentifier = "NormalCell"
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
  private let containerLayoutGuide = UILayoutGuide()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    containerLayoutGuide.topAnchor.constraint(equalTo:
      topAnchor, constant: 8).isActive = true
    containerLayoutGuide.leadingAnchor.constraint(equalTo:
      leadingAnchor, constant: 8).isActive = true
    containerLayoutGuide.trailingAnchor.constraint(equalTo:
      trailingAnchor, constant: -8).isActive = true
    containerLayoutGuide.bottomAnchor.constraint(equalTo:
      bottomAnchor, constant: -8).isActive = true
    
    titleLabel.topAnchor.constraint(equalTo: topAnchor,
                                    constant: 8).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                        constant: 8).isActive = true
    titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    
    detailLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
    detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                          constant: -50).isActive = true
    detailLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
  }
  
  func configure(title: String, detail: String, moreInfo: String? = nil) {
    addLayoutGuide(containerLayoutGuide)
    
    selectionStyle = .none
    titleLabel.text = title
    detailLabel.text = detail
    addSubview(titleLabel)
    addSubview(detailLabel)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = nil
    detailLabel.text = nil
  }
}

