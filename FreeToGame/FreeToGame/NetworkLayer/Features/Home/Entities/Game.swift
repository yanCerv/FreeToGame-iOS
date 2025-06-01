//
//  Game.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 29/11/24.
//

struct Game: Decodable, Hashable {
  let id: Int
  let title: String
  let thumbnail: String
  let shortDescription: String
  let gameURL: String
  let genre: String
  let platform: String
  let publisher: String
  let developer: String
  let releaseDate: String
  let freetogameProfileURL: String
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case title = "title"
    case thumbnail = "thumbnail"
    case shortDescription = "short_description"
    case gameURL = "game_url"
    case genre = "genre"
    case platform = "platform"
    case publisher = "publisher"
    case developer = "developer"
    case releaseDate = "release_date"
    case freetogameProfileURL = "freetogame_profile_url"
  }
  
  static func previewGame() -> Game {
    return Game(id: 582, title: "Tarisland",
                thumbnail: "https://www.freetogame.com/g/582/thumbnail.jpg",
                shortDescription: "A cross-platform MMORPG developed by Level Infinite and Published by Tencent",
                gameURL: "A cross-platform MMORPG developed by Level Infinite and Published by Tencent.",
                genre: "MMORPG",
                platform: "PC (Windows)",
                publisher: "Tencent",
                developer: "Level Infinite",
                releaseDate: "2024-06-22",
                freetogameProfileURL: "https://www.freetogame.com/tarisland")
  }
}
