//
//  Artwork.swift
//  StoreClone
//
//  Created by junwoo on 12/12/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import Foundation

struct Artwork {
  private var iconImageUrl: String
  public var name: String
  private var artist: String
  private var genres: [String]
  private var price: String
  private var rating: Double?
  private var screenshotUrls: [String]
  private var version: String
  private var releaseNotes: String?
  private var trackViewUrl: String
  private var description: String
  private var size: String
  private var age: String
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

