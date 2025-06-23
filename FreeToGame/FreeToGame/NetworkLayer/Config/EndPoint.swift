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
  var method: Method { get }
  var bodyRequest: String? { get }
}

extension EndPoint {
  
  private var environment: Environment {
    return Environment()
  }
  
  private var headers: [String: String] {
    return Headers.values()
  }
  
  private var methodValue: String {
    return method.rawValue
  }
  
  private var data: Data? {
    if let dataRequest = bodyRequest?.data(using: .utf8) {
      return dataRequest
    }
    return nil
  }
  
  private var baseUrl: URL {
    let stringBaseUrl = environment.get(.baseUrl)
    let stringUrl = "\(stringBaseUrl)\(path)"
    return URL(string: stringUrl)!
  }
  
  var request: URLRequest {
    var request = URLRequest(url: baseUrl)
    request.allHTTPHeaderFields = headers
    request.httpMethod = methodValue
    request.httpBody = methodValue == "GET" ? nil : data
    request.timeoutInterval = 300
    return request
  }
}
