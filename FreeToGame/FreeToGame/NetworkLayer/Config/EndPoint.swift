//
//  EndPoint.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 29/11/24.
//

import Foundation

enum Method: String {
  case post = "POST"
  case get = "GET"
  case put = "PUT"
  case delete = "DELETE"
  case patch = "PATCH"
  case head = "HEAD"
}

protocol EndPoint {
  var path: String { get }
  var bodyRequest: String? { get }
}

extension EndPoint {
  
  @MainActor
  private var headers: [String: String] {
    return Headers.values()
  }
  
  private var method: String {
    return Method.post.rawValue
  }
  
  private var data: Data? {
    if let dataRequest = bodyRequest?.data(using: .utf8) {
      return dataRequest
    }
    return nil
  }
  
  @MainActor
  private var baseUrl: URL {
    let stringBaseUrl = Environment.shared.get(.baseUrl)
    let stringUrl = "\(stringBaseUrl)\(path)"
    return URL(string: stringUrl)!
  }
  
  @MainActor
  var request: URLRequest {
    var request = URLRequest(url: baseUrl)
    request.allHTTPHeaderFields = headers
    request.httpMethod = method
    request.httpBody = data
    request.timeoutInterval = 300
    return request
  }
}
