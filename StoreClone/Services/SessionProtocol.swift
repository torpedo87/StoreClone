//
//  SessionProtocol.swift
//  StoreClone
//
//  Created by junwoo on 13/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import Foundation

protocol SessionProtocol {
  
  func dataTask(with url: URL,
                completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: SessionProtocol {}
