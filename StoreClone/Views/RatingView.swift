//
//  RatingView.swift
//  StoreClone
//
//  Created by junwoo on 16/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class RatingView: UIView {
  private var starImageViews = [UIImageView]()
  private var averageRating: Double!
  private let maxRating: Double = 5.0
  
  init(averageRating: Double) {
    self.averageRating = averageRating
    super.init(frame: CGRect.zero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupView()
  }
  
  func setupView() {
    let starWidth = self.bounds.width / CGFloat(maxRating)
    let fullStarCount = Int(averageRating)
    let hasHalfStar: Bool = averageRating - Double(fullStarCount) > 0
    
    var IsHalfStarAdded: Bool = false
    for i in 1...Int(maxRating) {
      var starImage: UIImage
      if i <= fullStarCount {
        starImage = UIImage(named: "full")!
      } else if hasHalfStar && !IsHalfStarAdded {
        starImage = UIImage(named: "half")!
        IsHalfStarAdded = true
      } else {
        starImage = UIImage(named: "empty")!
      }
      
      let starImageView = UIImageView(image: starImage)
      starImageView.translatesAutoresizingMaskIntoConstraints = false
      starImageView.contentMode = .scaleAspectFit
      addSubview(starImageView)
      
      starImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
      starImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
      starImageView.widthAnchor.constraint(equalToConstant: starWidth).isActive = true
      starImageView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                             constant: starWidth * CGFloat(i-1)).isActive = true
      starImageViews.append(starImageView)
    }
  }
  
  func reset() {
    starImageViews = []
    subviews.forEach{ $0.removeFromSuperview() }
  }
}
