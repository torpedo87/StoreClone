//
//  DataStore.swift
//  StoreClone
//
//  Created by junwoo on 29/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class DataStore {
  private var list: [Artwork]
  
  init(list: [Artwork]) {
    self.list = list
  }
  
  public func loadImageOperation(at index: Int) -> DataLoadOperation? {
    return DataLoadOperation(list[index].iconImageUrl)
  }
  
}


class DataLoadOperation: Operation {
  var iconUrlString: String?
  var icon: UIImage?
  var loadingCompleteHandler: ((UIImage) ->Void)?
  
  private let _iconUrlString: String
  
  init(_ iconUrlString: String) {
    _iconUrlString = iconUrlString
  }
  
  override func main() {
    
    if isCancelled { return }
    iconUrlString = _iconUrlString
    let url = URL(string: iconUrlString!)!
    let imgData = try! Data(contentsOf: url)
    if isCancelled { return }
    let iconImage = UIImage(data: imgData)
    icon = iconImage
    if let loadingCompleteHandler = loadingCompleteHandler {
      DispatchQueue.main.async {
        loadingCompleteHandler(iconImage!)
      }
    }
  }
}
