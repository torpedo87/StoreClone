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
  let keyword: String = "핸드메이드"
  
  private var list: [Artwork] = [] {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(ListCell.self,
                       forCellReuseIdentifier: ListCell.reusableIdentifier)
    return tableView
  }()
  
  init(manager: NetworkManager) {
    self.networkManager = manager
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    
    let url = networkManager.convertKeywordToUrl(keyword: keyword)
    networkManager.loadData(url: url) { [weak self] result in
      guard let self = self else { return }
      self.handleResult(result: result)
    }
  }
  
  func handleResult(result: Result<Data, LoadingError>) {
    switch result {
    case .success(let data):
      let artworks = self.networkManager.convertDataToArtworks(data: data)
      self.list = artworks
    case .failure(let error):
      switch error {
      case .client:
        print("client error occured")
      case .server:
        print("server error occured")
      }
    }
  }
  
  func setupUI() {
    title = keyword
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

extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return list.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
  
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 500
  }
  
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    let selectedArtwork = list[indexPath.row]
    let detailViewController = DetailViewController(artwork: selectedArtwork)
    self.navigationController?.pushViewController(detailViewController,
                                                  animated: true)
  }
}
