//
//  JsonResource.swift
//  FreeToGameTests
//
//  Created by Yan Cervantes on 30/11/24.
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
