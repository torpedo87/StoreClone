//
//  Artwork.swift
//  StoreClone
//
//  Created by junwoo on 12/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import Foundation

struct Artwork {
  private(set) var iconImageUrl: String
  private(set) var name: String
  private(set) var artist: String
  private(set) var genres: [String]
  private(set) var price: String
  private(set) var rating: Double?
  private(set) var screenshotUrls: [String]
  private(set) var version: String
  private(set) var releaseNotes: String?
  private(set) var trackViewUrl: String
  private(set) var description: String
  private(set) var size: String
  private(set) var age: String
}


extension Artwork {
  
  
  init?(result: [String: Any]) {
    
    guard let iconImageUrl = result["artworkUrl512"] as? String,
      let name = result["trackName"] as? String,
      let artist = result["sellerName"] as? String,
      let genres = result["genres"] as? [String],
      let price = result["formattedPrice"] as? String,
      let rating = result["averageUserRatingForCurrentVersion"] as? Double?,
      let screenshotUrls = result["screenshotUrls"] as? [String],
      let version = result["version"] as? String,
      let releaseNotes = result["releaseNotes"] as? String?,
      let trackViewUrl = result["trackViewUrl"] as? String,
      let description = result["description"] as? String,
      let size = result["fileSizeBytes"] as? String,
      let age = result["contentAdvisoryRating"] as? String else {
      return nil
    }
    
    self.iconImageUrl = iconImageUrl
    self.name = name
    self.artist = artist
    self.genres = genres
    self.price = price
    self.rating = rating
    self.screenshotUrls = screenshotUrls
    self.version = version
    self.releaseNotes = releaseNotes
    self.trackViewUrl = trackViewUrl
    self.description = description
    self.size = size
    self.age = age
  }
}

