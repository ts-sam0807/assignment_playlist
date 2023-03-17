//
//  main.swift
//  Playlist
//
//  Created by Ts SaM on 16/3/2023.
//

import Foundation

var playlist = Playlist()

while true {
  playlist.printMenu()
  print("Enter your choice: ", terminator: "")
  if let input = readLine()?.lowercased() {
    switch input {
    case "a":
      playlist.addSong()
      break
    case "f":
      playlist.findSong()
      break
    case "d":
      playlist.deleteSong()
      break
    case "s":
      playlist.printPlaylist()
      break
    case "c":
      playlist.printCategoryPlaylist()
      break
    case "z":
      playlist.printPlaylistSize()
      break
    case "m":
      playlist.printMenu()
      break
    case "x":
      print("Exiting program...")
      exit(0)
    default:
      print("Invalid choice, try again.")
    }
  }
}

