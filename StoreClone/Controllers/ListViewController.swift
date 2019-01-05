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
  var loadingOperations: [IndexPath: DataLoadOperation] = [:]
  var loadingQueue = OperationQueue()
  var dataStore: DataStore = DataStore(list: [])
  
  private var list: [Artwork] = []
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
    tableView.prefetchDataSource = self
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
      self.dataStore = DataStore(list: artworks)
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
      cell.configure(artwork: artwork, iconImage: .none)
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
    let detailsViewController = DetailsViewController(artwork: selectedArtwork)
    self.navigationController?.pushViewController(detailsViewController,
                                                  animated: true)
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let cell = cell as? ListCell else { return }
    
    let updateCellClosure: (UIImage?) -> () = { [weak self] iconImage in
      guard let self = self else {
        return
      }
      cell.configure(artwork: self.list[indexPath.row], iconImage: iconImage)
      self.loadingOperations.removeValue(forKey: indexPath)
    }
    
    if let loadOperation = loadingOperations[indexPath] {
      if let icon = loadOperation.icon {
        cell.configure(artwork: self.list[indexPath.row], iconImage: icon)
        loadingOperations.removeValue(forKey: indexPath)
      } else {
        loadOperation.loadingCompleteHandler = updateCellClosure
      }
    } else {
      if let loadOperation = dataStore.loadImageOperation(at: indexPath.row) {
        loadOperation.loadingCompleteHandler = updateCellClosure
        loadingQueue.addOperation(loadOperation)
        loadingOperations[indexPath] = loadOperation
      }
    }
  }
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if let loadOperation = loadingOperations[indexPath] {
      loadOperation.cancel()
      loadingOperations.removeValue(forKey: indexPath)
    }
  }
}

extension ListViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    for indexPath in indexPaths {
      if let _ = loadingOperations[indexPath] {
        continue
      }
      if let loadOperation = dataStore.loadImageOperation(at: indexPath.row) {
        loadingQueue.addOperation(loadOperation)
        loadingOperations[indexPath] = loadOperation
      }
    }
  }
  
  func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    for indexPath in indexPaths {
      if let loadOperation = loadingOperations[indexPath] {
        loadOperation.cancel()
        loadingOperations.removeValue(forKey: indexPath)
      }
    }
  }
}
