//
//  GameDetail.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/06/25.
//

struct GameDetail: Decodable {
  let id: Int
  let title: String
  let thumbnail: String
  let status: String
  let shortDescription: String
  let welcomeDescription: String
  let gameURL: String
  let genre: String
  let platform: String
  let publisher: String
  let developer: String
  let releaseDate: String
  let freetogameProfileURL: String
  let minimumSystemRequirements: MinimumSystemRequirements?
  let screenshots: [Screenshot]
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case title = "title"
    case thumbnail = "thumbnail"
    case status = "status"
    case shortDescription = "short_description"
    case welcomeDescription = "description"
    case gameURL = "game_url"
    case genre = "genre"
    case platform = "platform"
    case publisher = "publisher"
    case developer = "developer"
    case releaseDate = "release_date"
    case freetogameProfileURL = "freetogame_profile_url"
    case minimumSystemRequirements = "minimum_system_requirements"
    case screenshots = "screenshots"
  }
  
  var requirements: MinimumSystemRequirements {
    guard let minimumSystemRequirements else { return MinimumSystemRequirements.empty()}
    return minimumSystemRequirements
  }
  
  static func emptyObject() -> GameDetail {
    return GameDetail(id: 0,
                      title: "",
                      thumbnail: "",
                      status: "",
                      shortDescription: "",
                      welcomeDescription: "",
                      gameURL: "",
                      genre: "",
                      platform: "",
                      publisher: "",
                      developer: "",
                      releaseDate: "",
                      freetogameProfileURL: "",
                      minimumSystemRequirements: MinimumSystemRequirements(os: "",
                                                                           processor: "",
                                                                           memory: "",
                                                                           graphics: "",
                                                                           storage: ""),
                      screenshots: []
    )
  }
}
