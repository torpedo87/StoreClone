//
//  NetworkManager.swift
//  StoreClone
//
//  Created by junwoo on 13/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import Foundation

enum Result<Value, Error: Swift.Error> {
  case success(Value)
  case failure(Error)
}

extension Result {
  func resolve() throws -> Value {
    switch self {
    case .success(let value):
      return value
    case .failure(let error):
      throw error
    }
  }
}

enum LoadingError: Error {
  case client
  case server
}

typealias Handler = (Result<[Artwork], LoadingError>) -> Void

class NetworkManager {
  
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  func loadData(keyword: String,
                comopletionHandler: @escaping Handler) {
    
    let url = convertKeywordToUrl(keyword: keyword)
    let task = session.dataTask(with: url) { (data, response, error) in
      
      if let _ = error {
        comopletionHandler(.failure(.client))
        return
      }
      
      if let httpResponse = response as? HTTPURLResponse,
        let statusCode = httpResponse.statusCode as? Int {
        if !(200...299).contains(statusCode) {
          comopletionHandler(.failure(.server))
          return
        }
      }
      
      if let data = data,
        let json = try? JSONSerialization.jsonObject(with: data, options: []),
        let dict = json as? [String: Any],
        let results = dict["results"] as? [[String:Any]] {
        var list: [Artwork] = []
        for result in results {
          let artwork = Artwork(result: result)
          list.append(artwork!)
        }
        comopletionHandler(.success(list))
      }
      
    }
    task.resume()
  }
  
  func convertKeywordToUrl(keyword: String) -> URL {
    let parameters = [
      "term": keyword,
      "country": "kr",
      "media": "software"
    ]
    
    var queryComponents: [URLQueryItem] {
      var components = [URLQueryItem]()
      for (key, value) in parameters {
        let queryItem = URLQueryItem(name: key, value: value)
        components.append(queryItem)
      }
      return components
    }
    var components = URLComponents(string: "http://itunes.apple.com/search")!
    components.queryItems = queryComponents
    return components.url!
  }
  
}
