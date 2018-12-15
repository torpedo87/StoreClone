//
//  TopCell.swift
//  StoreClone
//
//  Created by junwoo on 14/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class TopCell: UITableViewCell {
  
  static let reuseIdentifier = "TopCell"
  private var artwork: Artwork! {
    didSet {
      collectionView.reloadData()
    }
  }
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = artwork.name
    return label
  }()
  private lazy var sellerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = artwork.artist
    return label
  }()
  private lazy var priceLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = artwork.price
    return label
  }()
  
  private lazy var customLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 + 50, height: UIScreen.main.bounds.height/2 - 30)
    layout.scrollDirection = .horizontal
    return layout
  }()
  
  private lazy var collectionView: UICollectionView = {
    let view = UICollectionView(frame: CGRect.zero,
                                collectionViewLayout: customLayout)
    view.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    view.backgroundColor = .green
    view.dataSource = self
    view.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.reuseIdentifier)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private lazy var stackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 8
    stack.alignment = .fill
    stack.distribution = .fillEqually
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  private lazy var buttonStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.spacing = 8
    stack.alignment = .fill
    stack.distribution = .fillEqually
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  private lazy var webButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("웹에서 보기", for: .normal)
    button.addTarget(self, action: #selector(webButtonTapped(_:)), for: .touchUpInside)
    button.layer.borderWidth = 0.5
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  private lazy var shareButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("공유하기", for: .normal)
    button.addTarget(self, action: #selector(shareButtonTapped(_:)), for: .touchUpInside)
    button.layer.borderWidth = 0.5
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    collectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2).isActive = true
    
    stackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
    stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
    stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9).isActive = true
  }
  
  func configure(artwork: Artwork) {
    selectionStyle = .none
    backgroundColor = .yellow
    self.artwork = artwork
    addSubview(collectionView)
    addSubview(stackView)
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(sellerLabel)
    stackView.addArrangedSubview(priceLabel)
    stackView.addArrangedSubview(buttonStackView)
    buttonStackView.addArrangedSubview(webButton)
    buttonStackView.addArrangedSubview(shareButton)
  }
  
  @objc func webButtonTapped(_ recognizer: UIButton) {
    if let url = URL(string: artwork.trackViewUrl) {
      print(artwork.trackViewUrl)
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  }
  
  @objc func shareButtonTapped(_ recognizer: UIButton) {
    
  }
}

extension TopCell: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.artwork.screenshotUrls.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.reuseIdentifier,
                                                     for: indexPath) as? CarouselCell {
      cell.configure(screenshotUrlString: artwork.screenshotUrls[indexPath.item])
      return cell
    }
    return UICollectionViewCell()
  }
}
