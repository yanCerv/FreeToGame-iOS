//
//  JsonResource.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/12/24.
//

import Foundation

actor JsonResource {
  static func getFrom<T: Decodable>(_ fileName: String, type: T.Type) throws -> T {
    let bundle = Bundle(for: JsonResource.self)
    let url = bundle.url(forResource: fileName, withExtension: "json")!
    do {
      return try JSONDecoder().decode(type.self, from: Data(contentsOf: url))
    } catch {
      throw error
    }
  }
}
