//
//  Playlist.swift
//  Assignment4
//
//  Created by Derrick Park on 2023-03-03.
//

import Foundation

struct Playlist {
  private(set) var songs: [Song] = [
    Song(title: "Billie Jean", artist: "Michael Jackson", category: .rnb, size: 5923),
    Song(title: "Someone Singing Along", artist: "James Blunt", category: .pop, size: 2123),
    Song(title: "Highway To Hell", artist: "AC/DC", category: .rock, size: 4232),
    Song(title: "Lost", artist: "Linkin Park", category: .rock, size: 3424),
    Song(title: "It's My Life", artist: "Bon Jovi", category: .rock, size: 3231),
    Song(title: "Thriller", artist: "Michael Jackson", category: .rnb, size: 5432),
    Song(title: "Beat It", artist: "Michael Jackson", category: .rnb, size: 5432),
  ]
  
  var songsTotalSize: Int {
    return songs.reduce(0, { $0 + $1.size })
  }
  
  var songsTotalSizeInMB: String {
    return String(format: "%.1f", Double(songsTotalSize) / 1000.0)
  }
  /*----------------*/
  /*------ Add -----*/
  /*----------------*/
  public mutating func addSong() {
    // Input the song title
    print("Enter a new song's title: (max 35 characters):")
    var title = ""
    repeat {
      title = readLine() ?? ""
      if title.count < 1 || title.count > 35 {
        print("Invalid title length. Please re-enter (max 35 characters):")
      }
    } while title.count < 1 || title.count > 35
    
    // Input the song artist
    print("Enter a new song's artist: (max 20 characters):")
    var artist = ""
    repeat {
      artist = readLine() ?? ""
      if artist.count < 1 || artist.count > 20 {
        print("Invalid artist length. Please re-enter (max 20 characters):")
      }
    } while artist.count < 1 || artist.count > 20
    
    // Input the song category
    print("Enter a new song's category (P: Pop, R: Rock, A: Alternative, B: RnB, H: Hiphop, C: Classical):")
    var category: Song.Style?
    repeat {
      if let input = readLine()?.lowercased(), input.count == 1 {
        switch input {
        case "p": category = .pop
        case "r": category = .rock
        case "a": category = .alternative
        case "b": category = .rnb
        case "h": category = .hiphop
        case "c": category = .classical
        default:
          print("Invalid category. Please re-enter (P/R/A/B/H/C).")
        }
      }
    } while category == nil
    
    // Input the song size
    print("Enter a new song's size(KB):")
    var size = 0
    repeat {
      if let sizeInput = readLine(), let sizeInt = Int(sizeInput), sizeInt > 0 {
        size = sizeInt
      } else {
        print("Must enter a positive size. Please re-enter:")
      }
    } while size <= 0
    
    let newSong = Song(title: title, artist: artist, category: category!, size: size)
    songs.append(newSong)
    print("\(title) by \(artist) has been added to the playlist.")
  }
  
  /*-----------------*/
  /*------ Read -----*/
  /*-----------------*/
  public func printPlaylist() {
    // Define table header
    printTableHead()
    
    // Loop the songs and print rows
    for song in songs {
      print(song.description)
    }
    // Loop the sammary information
    printTableFooter()
    print("Total: \(songs.count) songs in the playlist.");
    print("Size: \(songsTotalSizeInMB) MB.");
  }
  
  /*-------------------*/
  /*------ Delete -----*/
  /*-------------------*/
  mutating func deleteSong()
  {
    print("Delete a song from the playlist!")
    print("Enter the title of the song you want to remove from your playlist:")
    let _title = readLine() ?? ""
    var _songIndex: Int?
    
    // Loop the song list
    for (index, song) in songs.enumerated() {
      if song.title == _title {
        _songIndex = index
        break
      }
    }
    
    if _songIndex != nil {
      songs.remove(at: _songIndex!)
      print("\(_title) : Successfully removed the song from the playlist.")
    } else {
      print("No such title: '\(_title)' in the list")
    }
  }
  
  /*-----------------*/
  /*------ List -----*/
  /*-----------------*/
  func printCategoryPlaylist() {
    print("List out the songs by category (P: Pop, R: Rock, A: Alternative, B: RnB, H: Hiphop, C: Classical):")
    var category: Song.Style?
    repeat {
      if let input = readLine()?.lowercased(), input.count == 1 {
        switch input {
        case "p": category = .pop
        case "r": category = .rock
        case "a": category = .alternative
        case "b": category = .rnb
        case "h": category = .hiphop
        case "c": category = .classical
        default:
          print("Invalid category. Please re-enter (P/R/A/B/H/C).")
        }
      }
    } while category == nil
    
    var categorySongs = [Song]()
    var totalSize = 0
    for song in songs {
      if song.category == category {
        categorySongs.append(song)
        totalSize += song.size
      }
    }
    
    if categorySongs.isEmpty {
      print("No songs found in category: \(category!).")
      return
    }else{
      // Loop through songs of the table rows
      printTableHead()
      for song in categorySongs {
        print(song.description)
      }
      printTableFooter()
      print("Total: \(categorySongs.count) songs in the playlist.");
      print("Size: " + String(format: "%.1f", Double(categorySongs.map({ $0.size }).reduce(0, +)) / 1000.0) + " MB.");
      
    }
  }
  
  /*-------------------*/
  /*------ Search -----*/
  /*-------------------*/
  func findSong() {
    print("Find a song on the playlist!")
    print("Enter your search Keyword:")
    guard let searchString = readLine() else {
      print("Invalid input.")
      return
    }
    
    var matchedTitles: [Song] = []
    var matchedArtists: [Song] = []
    
    for song in songs {
      if song.title.localizedCaseInsensitiveContains(searchString) {
        matchedTitles.append(song)
      }
      if song.artist.localizedCaseInsensitiveContains(searchString) {
        matchedArtists.append(song)
      }
    }
    
    // Print matched titles
    print("=== Matched Titles ===")
    if matchedTitles.isEmpty {
      print("=== 0 matches ===")
    } else {
      for song in matchedTitles {
        print(song.description)
      }
      print("=== \(matchedTitles.count) matches ===")
    }
    
    // Print matched artists
    print("=== Matched Artists ===")
    if matchedArtists.isEmpty {
      print("=== 0 matches ===")
    } else {
      for song in matchedArtists {
        print(song.description)
      }
      print("=== \(matchedArtists.count) matches ===")
    }
  }
  
  /*-------------------*/
  /*------ Print ------*/
  /*-------------------*/
  private func printTableHead() {
    print("+-------------------------------------+--------------------------+-------------+-----------")
    print("| Title                               | Artist                   | Style       | Size (MB) ")
    print("+-------------------------------------+--------------------------+-------------+-----------")
  }
  
  private func printTableFooter() {
    print("+-------------------------------------+--------------------------+-------------+-----------")
  }
  
  func printPlaylistSize() {
    print("Show playlist size!")
    print("Total size:: \(songsTotalSize) KB")
  }
  
  /*-------------------*/
  /*------- Menu ------*/
  /*-------------------*/
  func printMenu() {
    print();
    print("A: Add a song to the playlist")
    print("F: Find a song on the playlist")
    print("D: Delete a song from the playlist")
    print("S: Show the entire playlist")
    print("C: Category summary")
    print("Z: Show playlist size")
    print("M: Show this menu")
    print("X: Exit the program")
    print();
  }
  
  
}
