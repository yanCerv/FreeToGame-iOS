//
//  DetailClientResource.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/06/25.
//

import Foundation

enum DetailClientResource {
  case detail(gameId: Int)
}

extension DetailClientResource {
  var config: RequestConfiguration {
    switch self {
    case .detail(let gameId):
      let path = "/game?id=\(gameId)"
      return RequestConfiguration(path: path, method: .get)
    }
  }
}
