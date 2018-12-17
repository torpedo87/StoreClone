//
//  DetailViewController.swift
//  StoreClone
//
//  Created by junwoo on 14/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  private var artwork: Artwork!
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(TopCell.self,
                       forCellReuseIdentifier: TopCell.reuseIdentifier)
    tableView.register(DynamicCell.self,
                       forCellReuseIdentifier: DynamicCell.reuseableIdentifier)
    tableView.register(StandardCell.self,
                       forCellReuseIdentifier: StandardCell.reuseIdentifier)
    tableView.register(CategoryCell.self,
                       forCellReuseIdentifier: CategoryCell.reuseIdentifier)
    tableView.estimatedRowHeight = 500
    tableView.rowHeight = UITableView.automaticDimension
    return tableView
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
    view.addSubview(tableView)
    tableView.topAnchor.constraint(equalTo:
      view.safeAreaLayoutGuide.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo:
      view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo:
      view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo:
      view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
}

extension DetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return 6
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      if let cell = tableView.dequeueReusableCell(withIdentifier: TopCell.reuseIdentifier,
                                                  for: indexPath) as? TopCell {
        cell.configure(artwork: artwork)
        cell.delegate = self
        return cell
      }
    case 1:
      if let cell = tableView.dequeueReusableCell(withIdentifier: StandardCell.reuseIdentifier,
                                                  for: indexPath) as? StandardCell {
        cell.configure(title: "크기", detail: artwork.readableSize)
        return cell
      }
    case 2:
      if let cell = tableView.dequeueReusableCell(withIdentifier: StandardCell.reuseIdentifier,
                                                  for: indexPath) as? StandardCell {
        cell.configure(title: "연령", detail: artwork.age)
        return cell
      }
    case 3:
      if let cell = tableView.dequeueReusableCell(withIdentifier: DynamicCell.reuseableIdentifier,
                                                  for: indexPath) as? DynamicCell {
        cell.delegate = self
        cell.configure(title: "새로운 기능", detail: artwork.version, artWork: artwork)
        return cell
      }
    case 4:
      if let cell = tableView.dequeueReusableCell(withIdentifier: StandardCell.reuseIdentifier,
                                                  for: indexPath) as? StandardCell {
        cell.configure(artWork: artwork)
        return cell
      }
    case 5:
      if let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseIdentifier,
                                                  for: indexPath) as? CategoryCell {
        cell.configure(genre: artwork.genres)
        return cell
      }
    default:
      return UITableViewCell()
    }
    return UITableViewCell()
  }
}

extension DetailViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return UIScreen.main.bounds.height * 2 / 3
    } else if indexPath.row == 4 {
      return UIScreen.main.bounds.height / 3
    } else if indexPath.row == 5 {
      return UIScreen.main.bounds.height / 7
    }
    return UITableView.automaticDimension
  }
}

extension DetailViewController: DynamicCellDelegate {
  func moreInfoButtonTapped() {
    tableView.beginUpdates()
    tableView.layoutIfNeeded()
    tableView.endUpdates()
  }
}

extension DetailViewController: TopCellDelegate {
  func shareButtonTapped() {
    if let urlToShare = URL(string: artwork.trackViewUrl) {
      let activityViewController = UIActivityViewController(activityItems: [urlToShare],
                                                            applicationActivities: nil)
      self.present(activityViewController, animated: true, completion: nil)
    }
  }
}
