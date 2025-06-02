//
//  HomeClientResource.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 29/11/24.
//

import Foundation

enum HomeClientResources {
  case getGames
}

extension HomeClientResources {
  var config: RequestConfiguration {
    switch self {
    case .getGames:
      let path = "/games"
      return  RequestConfiguration(path: path, method: .get)
    }
  }
}
