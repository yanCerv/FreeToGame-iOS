//
//  RequestConfiguration.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 29/11/24.
//

struct RequestConfiguration: EndPoint {
  var path: String
  var method: Method
  var bodyRequest: String?
}
