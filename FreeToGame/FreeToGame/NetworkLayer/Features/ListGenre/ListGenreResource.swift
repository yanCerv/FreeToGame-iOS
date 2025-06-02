//
//  ListGenreResource.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 01/06/25.
//

enum ListGenreResource {
  case getgames(genre: String)
}

extension ListGenreResource {
  var config: RequestConfiguration {
    switch self {
    case .getgames(let genre):
      let path = "/games?category=\(genre)"
      return  RequestConfiguration(path: path, method: .get)
    }
  }
}
