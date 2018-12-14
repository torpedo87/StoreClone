//
//  UIImageView.swift
//  StoreClone
//
//  Created by junwoo on 14/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
  
  func loadImageWithUrlString(urlString: String) {
    let url = URL(string: urlString)
    
    if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
      self.image = imageFromCache
      return
    }
    
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
      if error != nil {
        print(error.debugDescription)
        return
      }
      DispatchQueue.main.async {
        let imageToCache = UIImage(data: data!)
        imageCache.setObject(imageToCache!, forKey: urlString as NSString)
        self.image = imageToCache
      }
      
      }.resume()
  }
}
