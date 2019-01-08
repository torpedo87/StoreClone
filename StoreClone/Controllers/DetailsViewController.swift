//
//  DetailsViewController.swift
//  StoreClone
//
//  Created by junwoo on 05/01/2019.
//  Copyright © 2019 samchon. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
  
  private var artwork: Artwork!
  private let screenWidth = UIScreen.main.bounds.width
  private let screenHeight = UIScreen.main.bounds.height
  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  private lazy var customLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 + 50,
                             height: UIScreen.main.bounds.height/2 - 30)
    layout.scrollDirection = .horizontal
    return layout
  }()
  
  private lazy var collectionView: UICollectionView = {
    let view = UICollectionView(frame: CGRect.zero,
                                collectionViewLayout: customLayout)
    view.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    view.dataSource = self
    view.register(CarouselCell.self,
                  forCellWithReuseIdentifier: CarouselCell.reuseIdentifier)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    return view
  }()
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .center
    return stackView
  }()
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = artwork.name
    label.font = UIFont.systemFont(ofSize: 20)
    label.sizeToFit()
    return label
  }()
  private lazy var sellerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = artwork.artist
    label.font = UIFont.systemFont(ofSize: 12)
    label.sizeToFit()
    return label
  }()
  private lazy var priceLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = artwork.price
    label.font = UIFont.systemFont(ofSize: 20)
    label.sizeToFit()
    return label
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
  lazy var webButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("웹에서 보기", for: .normal)
    button.addTarget(self, action: #selector(webButtonTapped(_:)),
                     for: .touchUpInside)
    button.layer.borderWidth = 0.5
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  lazy var shareButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("공유하기", for: .normal)
    button.addTarget(self, action: #selector(shareButtonTapped(_:)),
                     for: .touchUpInside)
    button.layer.borderWidth = 0.5
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  private var cellStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  private lazy var sizeView: CellView = {
    let cellView = CellView(frame: CGRect.zero, title: "크기",
                            detail: artwork.readableSize, isDynamic: false)
    cellView.translatesAutoresizingMaskIntoConstraints = false
    return cellView
  }()
  private lazy var ageView: CellView = {
    let cellView = CellView(frame: CGRect.zero, title: "연령",
                            detail: artwork.age, isDynamic: false)
    cellView.translatesAutoresizingMaskIntoConstraints = false
    return cellView
  }()
  lazy var featureView: CellView = {
    let cellView = CellView(frame: CGRect.zero, title: "새로운 기능",
                            detail: artwork.version, isDynamic: true)
    cellView.translatesAutoresizingMaskIntoConstraints = false
    cellView.delegate = self
    return cellView
  }()
  lazy var featureTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.backgroundColor = UIColor(red: 0.95, green: 0.95,
                                       blue: 0.95, alpha: 1)
    textView.text = artwork.releaseNotes
    textView.isScrollEnabled = false
    textView.isHidden = true
    return textView
  }()
  private lazy var descriptionTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.text = artwork.description
    textView.isScrollEnabled = true
    textView.textAlignment = .center
    return textView
  }()
  private lazy var categoryView: CategoryView = {
    let categoryView = CategoryView(genres: artwork.genres)
    categoryView.translatesAutoresizingMaskIntoConstraints = false
    return categoryView
  }()
  
  init(artwork: Artwork) {
    self.artwork = artwork
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  func setupUI() {
    navigationController?.navigationBar.prefersLargeTitles = false
    view.backgroundColor = .white
    
    view.addSubview(scrollView)
    scrollView.addSubview(stackView)
    stackView.addArrangedSubview(collectionView)
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(sellerLabel)
    stackView.addArrangedSubview(priceLabel)
    buttonStackView.addArrangedSubview(webButton)
    buttonStackView.addArrangedSubview(shareButton)
    stackView.addArrangedSubview(buttonStackView)
    cellStackView.addArrangedSubview(sizeView)
    cellStackView.addArrangedSubview(ageView)
    cellStackView.addArrangedSubview(featureView)
    cellStackView.addArrangedSubview(featureTextView)
    stackView.addArrangedSubview(cellStackView)
    stackView.addArrangedSubview(descriptionTextView)
    stackView.addArrangedSubview(categoryView)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    scrollView.topAnchor.constraint(equalTo:
      view.safeAreaLayoutGuide.topAnchor).isActive = true
    scrollView.leadingAnchor.constraint(equalTo:
      view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    scrollView.trailingAnchor.constraint(equalTo:
      view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo:
      view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
    stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    stackView.leadingAnchor.constraint(equalTo:
      scrollView.leadingAnchor, constant: 8).isActive = true
    stackView.trailingAnchor.constraint(equalTo:
      scrollView.trailingAnchor, constant: -8).isActive = true
    stackView.bottomAnchor.constraint(equalTo:
      scrollView.bottomAnchor).isActive = true
    
    collectionView.heightAnchor.constraint(equalToConstant: screenHeight/2).isActive = true
    collectionView.widthAnchor.constraint(equalToConstant: screenWidth - 20).isActive = true
    
    titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    titleLabel.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
    sellerLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
    sellerLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
    priceLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
    priceLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
    buttonStackView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
    buttonStackView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
    
    cellStackView.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
    sizeView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
    ageView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
    featureView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
    featureTextView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
    descriptionTextView.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
    descriptionTextView.heightAnchor.constraint(equalToConstant: screenHeight/4).isActive = true
    categoryView.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
    categoryView.heightAnchor.constraint(equalToConstant: 150).isActive = true
  }
  
  @objc func webButtonTapped(_ recognizer: UIButton) {
    if let url = URL(string: artwork.trackViewUrl) {
      UIApplication.shared.open(url, options: [:],
                                completionHandler: nil)
    }
  }
  
  @objc func shareButtonTapped(_ recognizer: UIButton) {
    if let urlToShare = URL(string: artwork.trackViewUrl) {
      let activityViewController = UIActivityViewController(activityItems: [urlToShare],
                                                            applicationActivities: nil)
      self.present(activityViewController, animated: true, completion: nil)
    }
  }
}

extension DetailsViewController: CellViewDelegate {
  func moreInfoButtonTapped() {
    UIView.animate(withDuration: 0.5) {
      self.featureTextView.isHidden = !self.featureTextView.isHidden
      self.featureTextView.layoutIfNeeded()
    }
  }
}

extension DetailsViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return self.artwork.screenshotUrls.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.reuseIdentifier,
                                                     for: indexPath) as? CarouselCell {
      cell.configure(screenshotUrlString: artwork.screenshotUrls[indexPath.item])
      return cell
    }
    return UICollectionViewCell()
  }
}
