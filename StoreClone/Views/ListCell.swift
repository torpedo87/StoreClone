//
//  ListCell.swift
//  StoreClone
//
//  Created by junwoo on 13/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
  
  static let reusableIdentifier: String = "ListCell"
  private let containerLayoutGuide = UILayoutGuide()
  private lazy var imgView: UIImageView = {
    let imgView = UIImageView()
    imgView.translatesAutoresizingMaskIntoConstraints = false
    imgView.contentMode = .scaleAspectFill
    return imgView
  }()
  private lazy var topView: UIView = {
    let topView = UIView()
    topView.translatesAutoresizingMaskIntoConstraints = false
    topView.backgroundColor = .white
    return topView
  }()
  private lazy var bottomView: UIView = {
    let bottomView = UIView()
    bottomView.translatesAutoresizingMaskIntoConstraints = false
    bottomView.backgroundColor = .white
    return bottomView
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var sellerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var categoryLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var priceLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override func layoutSubviews() {
    containerLayoutGuide.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
    containerLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
    containerLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    containerLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    
    imgView.topAnchor.constraint(equalTo: containerLayoutGuide.topAnchor).isActive = true
    imgView.leadingAnchor.constraint(equalTo: containerLayoutGuide.leadingAnchor).isActive = true
    imgView.trailingAnchor.constraint(equalTo: containerLayoutGuide.trailingAnchor).isActive = true
    imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor).isActive = true
    
    topView.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 5).isActive = true
    topView.leadingAnchor.constraint(equalTo: containerLayoutGuide.leadingAnchor).isActive = true
    topView.trailingAnchor.constraint(equalTo: containerLayoutGuide.trailingAnchor).isActive = true
    topView.heightAnchor.constraint(equalTo: bottomView.heightAnchor).isActive = true
    
    bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5).isActive = true
    bottomView.leadingAnchor.constraint(equalTo: containerLayoutGuide.leadingAnchor).isActive = true
    bottomView.trailingAnchor.constraint(equalTo: containerLayoutGuide.trailingAnchor).isActive = true
    bottomView.bottomAnchor.constraint(equalTo: containerLayoutGuide.bottomAnchor).isActive = true
    
    titleLabel.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
    titleLabel.widthAnchor.constraint(equalTo: topView.widthAnchor).isActive = true
    titleLabel.heightAnchor.constraint(equalTo: sellerLabel.heightAnchor).isActive = true
    
    sellerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
    sellerLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
    sellerLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
    sellerLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
    
    categoryLabel.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
    categoryLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
    categoryLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    categoryLabel.heightAnchor.constraint(equalTo: priceLabel.heightAnchor).isActive = true
    
    priceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor).isActive = true
    priceLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
    priceLabel.widthAnchor.constraint(equalTo: categoryLabel.widthAnchor).isActive = true
    priceLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
  }
  
  func configure(artwork: Artwork) {
    selectionStyle = .none
    backgroundColor = .lightGray
    addLayoutGuide(containerLayoutGuide)
    addSubview(imgView)
    addSubview(topView)
    addSubview(bottomView)
    topView.addSubview(titleLabel)
    topView.addSubview(sellerLabel)
    bottomView.addSubview(categoryLabel)
    bottomView.addSubview(priceLabel)
    
    imgView.loadImageWithUrlString(urlString: artwork.iconImageUrl)
    titleLabel.text = artwork.name
    sellerLabel.text = artwork.artist
    categoryLabel.text = artwork.genres.first
    priceLabel.text = artwork.price
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imgView.image = nil
    titleLabel.text = nil
    sellerLabel.text = nil
    categoryLabel.text = nil
    priceLabel.text = nil
  }
}
