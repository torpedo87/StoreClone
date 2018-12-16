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

class NetworkManager {
  
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  func loadData(url: URL,
                comopletionHandler: @escaping (Result<Data, LoadingError>) -> Void) {
    
    let task = session.dataTask(with: url) { (data, response, error) in
      
      if let _ = error {
        comopletionHandler(.failure(.client))
        return
      }
      
      if let httpResponse = response as? HTTPURLResponse {
        if !(200...299).contains(httpResponse.statusCode) {
          comopletionHandler(.failure(.server))
          return
        }
      }
      if let data = data {
        comopletionHandler(.success(data))
      }
    }
    task.resume()
  }
  
  func convertDataToArtworks(data: Data) -> [Artwork] {
    if let json = try? JSONSerialization.jsonObject(with: data, options: []),
      let dict = json as? [String: Any],
      let results = dict["results"] as? [[String:Any]] {
      var list: [Artwork] = []
      for result in results {
        let artwork = Artwork(result: result)
        list.append(artwork!)
      }
      return list
    }
    return []
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
