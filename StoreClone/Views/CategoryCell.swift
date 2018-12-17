//
//  CategoryCell.swift
//  StoreClone
//
//  Created by junwoo on 15/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
  static let reuseIdentifier = "CategoryCell"
  
  private lazy var containerGuide: UILayoutGuide = {
    let container = UILayoutGuide()
    return container
  }()
  private lazy var backView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    return view
  }()
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "카테고리"
    label.font = UIFont.systemFont(ofSize: 20)
    return label
  }()
  
  private lazy var categoryLabelView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private var categoryLabels = [UILabel]()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    containerGuide.topAnchor.constraint(equalTo: backView.topAnchor,
                                        constant: 8).isActive = true
    containerGuide.leadingAnchor.constraint(equalTo: backView.leadingAnchor,
                                            constant: 8).isActive = true
    containerGuide.trailingAnchor.constraint(equalTo: backView.trailingAnchor,
                                             constant: -8).isActive = true
    containerGuide.bottomAnchor.constraint(equalTo: backView.bottomAnchor,
                                           constant: -8).isActive = true
    
    backView.topAnchor.constraint(equalTo: topAnchor,
                                  constant: 8).isActive = true
    backView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    backView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    backView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                     constant: -8).isActive = true
    
    titleLabel.topAnchor.constraint(equalTo:
      containerGuide.topAnchor).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo:
      containerGuide.leadingAnchor).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo:
      containerGuide.trailingAnchor).isActive = true
    titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    categoryLabelView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                           constant: 8).isActive = true
    categoryLabelView.leadingAnchor.constraint(equalTo:
      containerGuide.leadingAnchor).isActive = true
    categoryLabelView.trailingAnchor.constraint(equalTo:
      containerGuide.trailingAnchor).isActive = true
    categoryLabelView.bottomAnchor.constraint(equalTo:
      containerGuide.bottomAnchor).isActive = true
    
    categoryLabels.forEach {
      categoryLabelView.addSubview($0)
    }
    
    var lastLabel: UILabel?
    for i in 0..<categoryLabels.count {
      let label = categoryLabels[i]
      label.textAlignment = .center
      label.widthAnchor.constraint(equalToConstant:
        label.intrinsicContentSize.width + 10).isActive = true
      label.heightAnchor.constraint(equalToConstant:
        label.intrinsicContentSize.height + 10).isActive = true
      if i == 0 {
        label.leadingAnchor.constraint(equalTo:
          categoryLabelView.leadingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo:
          categoryLabelView.centerYAnchor).isActive = true
      } else {
        if let last = lastLabel {
          label.leadingAnchor.constraint(equalTo: last.trailingAnchor,
                                         constant: 20).isActive = true
          label.centerYAnchor.constraint(equalTo:
            last.centerYAnchor).isActive = true
        }
      }
      lastLabel = label
    }
  }
  
  func configure(genre: [String]) {
    selectionStyle = .none
    backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    addLayoutGuide(containerGuide)
    addSubview(backView)
    backView.addSubview(titleLabel)
    backView.addSubview(categoryLabelView)
    
    for i in 0..<genre.count {
      let label = UILabel()
      label.layer.borderWidth = 0.5
      label.translatesAutoresizingMaskIntoConstraints = false
      label.text = "#\(genre[i])"
      self.categoryLabels.append(label)
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    categoryLabels = []
    categoryLabelView.subviews.forEach { $0.removeFromSuperview() }
  }
}
