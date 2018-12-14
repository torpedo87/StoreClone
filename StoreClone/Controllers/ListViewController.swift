//
//  ViewController.swift
//  StoreClone
//
//  Created by junwoo on 12/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
  var networkManager: NetworkManager!
  
  private var list: [Artwork] = []
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.reusableIdentifier)
    return tableView
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    
    networkManager.loadData(keyword: "핸드메이드") { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let artworks):
        self.list = artworks
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      case .failure(let error):
        switch error {
        case .client:
          print("client error occured")
        case .server:
          print("server error occured")
        }
      }
    }
  }
  
  func setupUI() {
    title = "핸드메이드"
    view.backgroundColor = .white
    view.addSubview(tableView)
    
    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }

  
}

extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return list.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reusableIdentifier,
                                                for: indexPath) as? ListCell {
      let artwork = self.list[indexPath.row]
      cell.configure(artwork: artwork)
      return cell
    }
    
    return UITableViewCell()
  }
  
  
}

extension ListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 500
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let selectedCell = tableView.cellForRow(at: indexPath) {
      selectedCell.isSelected = false
    }
    let selectedArtwork = list[indexPath.row]
    let detailViewController = DetailViewController()
    detailViewController.artwork = selectedArtwork
    self.navigationController?.pushViewController(detailViewController, animated: true)
  }
}
