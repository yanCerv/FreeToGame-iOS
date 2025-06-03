//
//  MinimumSystemRequirements.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/06/25.
//

struct MinimumSystemRequirements: Decodable {
  let os: String
  let processor: String
  let memory: String
  let graphics: String
  let storage: String
  
  static func empty() -> MinimumSystemRequirements {
    return MinimumSystemRequirements(os: "", processor: "", memory: "", graphics: "", storage: ""
    )
  }
}
