//
//  DynamicCell.swift
//  StoreClone
//
//  Created by junwoo on 14/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

protocol DynamicCellDelegate: class {
  func moreInfoButtonTapped()
}

class DynamicCell: StandardCell {
  static let reuseableIdentifier = "DynamicCell"
  weak var delegate: DynamicCellDelegate?
  private var isExpanded: Bool = false
  lazy var expandButton: UIButton = {
    let button = UIButton()
    button.setTitle("v", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(handleExpand(_:)),
                     for: .touchUpInside)
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  lazy var moreInfoLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.backgroundColor = .lightGray
    return label
  }()
  
  private lazy var moreInfoHeightConstraint: NSLayoutConstraint = {
    let heightConstraint = NSLayoutConstraint(
      item: moreInfoLabel,
      attribute: .height,
      relatedBy: .equal,
      toItem: nil,
      attribute: .height,
      multiplier: 0,
      constant: 0)
    return heightConstraint
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    expandButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    expandButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    expandButton.centerYAnchor.constraint(equalTo:
      titleLabel.centerYAnchor).isActive = true
    expandButton.leadingAnchor.constraint(equalTo: detailLabel.trailingAnchor,
                                          constant: 8).isActive = true
    
    moreInfoLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    moreInfoLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                           constant: 8).isActive = true
    moreInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                            constant: -8).isActive = true
    moreInfoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                       constant: 8).isActive = true
    moreInfoHeightConstraint.isActive = true
  }
  
  override func configure(title: String?, detail: String?, artWork: Artwork?) {
    super.configure(title: title, detail: detail, artWork: artWork)
    addSubview(expandButton)
    addSubview(moreInfoLabel)
    moreInfoLabel.text = artWork?.releaseNotes
  }
  
  @objc func handleExpand(_ recognizer: UIButton) {
    isExpanded = !isExpanded
    UIView.animate(withDuration: 0.5) {
      let angle: CGFloat = self.isExpanded ? .pi : 0.0
      self.expandButton.transform = CGAffineTransform(rotationAngle: angle)
      self.expandButton.layoutIfNeeded()
      self.moreInfoHeightConstraint.constant = self.isExpanded ? 100 : 0
      self.delegate?.moreInfoButtonTapped()
    }
  }
}
