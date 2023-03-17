//
//  Song.swift
//  Assignment4
//
//  Created by Derrick Park on 2023-03-03.
//

import Foundation

struct Song {
  enum Style: String {
    case pop, rock, alternative, rnb, hiphop, classical
  }
  // title of the song
  private(set) var title: String
  // artist of the song
  private(set) var artist: String
  // category of the song
  private(set) var category: Style
  // file size, stored in kilobytes
  private(set) var size: Int
  
  init(title: String, artist: String, category: Style, size: Int) {
    self.title = title
    self.artist = artist
    self.category = category
    self.size = size
  }
  
  mutating func setSong(title: String, artist: String, category: Style, size: Int) {
    self.title = title
    self.artist = artist
    self.category = category
    self.size = size
  }
}

extension Song: CustomStringConvertible {
  // Size should be printed in Megabytes (use 1000 kilobytes = 1 MB for this calculation), to 1 decimal place.
  // The category abbreviations used should be: Pop, Rock, Alt, Cls, HH, RnB
  // Example:
  // | Title                               | Artist                   | Style       | Size (MB)
  var description: String {
    let style: String
    switch category {
    case .pop:
      style = "Pop"
    case .rock:
      style = "Rock"
    case .alternative:
      style = "Alternative"
    case .classical:
      style = "Classical"
    case .hiphop:
      style = "Hiphop"
    case .rnb:
      style = "RnB"
    }
  
    let titleString = "\(title.padding(toLength: 35, withPad: " ", startingAt: 0))"
    let artistString = "\(artist.padding(toLength: 24, withPad: " ", startingAt: 0))"
    let categoryString = "\(style.padding(toLength: 11, withPad: " ", startingAt: 0))"
    let sizeString = "\(String(format: "%.1f", Double(size) / 1000.0).padding(toLength: 10, withPad: " ", startingAt: 0))"
    
    return "| \(titleString) | \(artistString) | \(categoryString) | \(sizeString) "
  }
}
