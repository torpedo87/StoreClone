//
//  CarouselCell.swift
//  StoreClone
//
//  Created by junwoo on 14/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class CarouselCell: UICollectionViewCell {
  
  static let reuseIdentifier = "CarouselCell"
  
  lazy var imgView: UIImageView = {
    let imgView = UIImageView()
    imgView.translatesAutoresizingMaskIntoConstraints = false
    imgView.clipsToBounds = true
    imgView.contentMode = .scaleAspectFill
    return imgView
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    imgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    imgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    imgView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    imgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
  
  func configure(screenshotUrlString: String) {
    addSubview(imgView)
    imgView.loadImageWithUrlString(urlString: screenshotUrlString)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imgView.image = nil
  }
}
