//
//  DetailViewController.swift
//  StoreClone
//
//  Created by junwoo on 14/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  var artwork: Artwork!
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(TopCell.self, forCellReuseIdentifier: TopCell.reuseIdentifier)
    tableView.register(DynamicCell.self, forCellReuseIdentifier: DynamicCell.reusableIdentifier)
    tableView.register(SelfSizingCell.self, forCellReuseIdentifier: SelfSizingCell.reuseIdentifier)
    tableView.register(NormalCell.self, forCellReuseIdentifier: NormalCell.reuseIdentifier)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 500
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  func setupUI() {
    navigationController?.navigationBar.prefersLargeTitles = false
    view.backgroundColor = .white
    view.addSubview(tableView)
    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
}

extension DetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      if let cell = tableView.dequeueReusableCell(withIdentifier: TopCell.reuseIdentifier,
                                                  for: indexPath) as? TopCell {
        cell.configure(artwork: artwork)
        return cell
      }
    case 1:
      if let cell = tableView.dequeueReusableCell(withIdentifier: NormalCell.reuseIdentifier,
                                                  for: indexPath) as? NormalCell {
        cell.configure(title: "크기", detail: artwork.size)
        return cell
      }
    case 2:
      if let cell = tableView.dequeueReusableCell(withIdentifier: NormalCell.reuseIdentifier,
                                                  for: indexPath) as? NormalCell {
        cell.configure(title: "연령", detail: artwork.age)
        return cell
      }
    case 3:
      if let cell = tableView.dequeueReusableCell(withIdentifier: DynamicCell.reusableIdentifier,
                                                  for: indexPath) as? DynamicCell {
        cell.configure(title: "새로운 기능", detail: artwork.version, moreInfo: artwork.releaseNotes)
        cell.delegate = self
        return cell
      }
    case 4:
      if let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizingCell.reuseIdentifier,
                                                  for: indexPath) as? SelfSizingCell {
        cell.configure(artwork: artwork)
        return cell
      }
    default:
      return UITableViewCell()
    }
    return UITableViewCell()
  }
  
  
}

extension DetailViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return UIScreen.main.bounds.height * 2 / 3
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
