//
//  CellView.swift
//  StoreClone
//
//  Created by junwoo on 05/01/2019.
//  Copyright © 2019 samchon. All rights reserved.
//

import UIKit

protocol CellViewDelegate: class {
  func moreInfoButtonTapped()
}

class CellView: UIView {
  
  private var isDynamic: Bool!
  private var isExpanded: Bool = false
  weak var delegate: CellViewDelegate?
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 20)
    return label
  }()
  
  private lazy var detailLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 12)
    return label
  }()
  lazy var expandButton: UIButton = {
    let button = UIButton()
    button.setTitle("v", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(handleExpand(_:)),
                     for: .touchUpInside)
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  
  init(frame: CGRect, title: String, detail: String, isDynamic: Bool) {
    self.isDynamic = isDynamic
    super.init(frame: frame)
    self.titleLabel.text = title
    self.detailLabel.text = detail
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    addTitleLabel()
    addDetailLabel()
    
    if isDynamic {
      addExpandButton()
    }
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
  
  func addExpandButton() {
    addSubview(expandButton)
    expandButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    expandButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    expandButton.centerYAnchor.constraint(equalTo:
      titleLabel.centerYAnchor).isActive = true
    expandButton.leadingAnchor.constraint(equalTo: detailLabel.trailingAnchor,
                                          constant: 8).isActive = true
  }
  
  @objc func handleExpand(_ recognizer: UIButton) {
    
    UIView.animate(withDuration: 0.5) {
      let angle: CGFloat = self.isExpanded ? .pi : 0.0
      self.expandButton.transform = CGAffineTransform(rotationAngle: angle)
      self.expandButton.layoutIfNeeded()
      self.delegate?.moreInfoButtonTapped()
    }
  }
}
