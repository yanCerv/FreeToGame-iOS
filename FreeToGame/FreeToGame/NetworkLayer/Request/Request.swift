//
//  Request.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 29/11/24.
//

import Foundation
import Combine

typealias PublisherResult<T: Decodable> = AnyPublisher<T, ErrorHandler>

protocol Request {
  func request<T: Decodable>(_ configuration: RequestConfiguration) -> PublisherResult<T>
}

private struct RequestSessionHolder {
  static let shared: URLSession = {
    let sessionDelegate = ClientURLSession()
    return URLSession(configuration: .default, delegate: sessionDelegate, delegateQueue: .main)
  }()
}

extension Request {
  
  func request<T: Decodable>(_ configuration: RequestConfiguration) -> PublisherResult<T> {
    let request = configuration.request
    return RequestSessionHolder.shared.dataTaskPublisher(for: request)
      .receive(on: DispatchQueue.main)
      .tryMap { element -> Data in
        guard let response = element.response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
          let statusCode = (element.response as? HTTPURLResponse)?.statusCode ?? -1
          throw ErrorHandler.error(message: "HTTP Error", statusCode: statusCode)
        }
        return element.data
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .mapError { error in
        return .jsonConversionFail(message: error.localizedDescription)
      }
      .eraseToAnyPublisher()
  }
}
