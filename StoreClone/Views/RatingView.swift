//
//  RatingView.swift
//  StoreClone
//
//  Created by junwoo on 15/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class RatingView: UIView {
  
  let maxRating: Double = 5.0
  
  private var averageRating: Double!
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    var lastStarImageView: UIImageView?
    let starWidth = self.bounds.width / CGFloat(maxRating)
    
    for i in 1...Int(maxRating) {
      let starImage = checkStarImage(result: averageRating - Double(i))
      let starImageView = UIImageView(image: starImage)
      starImageView.translatesAutoresizingMaskIntoConstraints = false
      starImageView.contentMode = .scaleAspectFit
      addSubview(starImageView)
      
      starImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
      starImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
      starImageView.widthAnchor.constraint(equalToConstant: starWidth).isActive = true
      
      if i == 1 {
        starImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
      } else {
        if let last = lastStarImageView {
          starImageView.leadingAnchor.constraint(equalTo: last.trailingAnchor).isActive = true
        }
      }
      lastStarImageView = starImageView
    }
  }
  
  func checkStarImage(result: Double) -> UIImage {
    if result == -0.5 {
      return UIImage(named: "half")!
    } else if result < -0.5 {
      return UIImage(named: "none")!
    } else {
      return UIImage(named: "full")!
    }
  }
  
  init(averageRating: Double) {
    self.averageRating = averageRating
    super.init(frame: CGRect.zero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
