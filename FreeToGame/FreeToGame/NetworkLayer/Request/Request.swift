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

/// Update for new swift 6 method
///  Swift Concurrency in the current state on protocol have some issues in client provider
///  changing to this method The provider had to be changed and testings need changes as well
actor RequestActor {
  static let shared: RequestActor = RequestActor()
  
  private let sessionDelegate = ClientURLSession()
  private lazy var session: URLSession = {
    return URLSession(configuration: .default, delegate: sessionDelegate, delegateQueue: nil)
  }()
  
  func request<T: Decodable>(_ configuration: RequestConfiguration) async throws -> T {
    let request = configuration.request
    let (data, response) = try await session.data(for: request)
    if let httpResponse = response as? HTTPURLResponse,
       (200...299).contains(httpResponse.statusCode) {
      return try JSONDecoder().decode(T.self, from: data)
    } else {
      let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
      throw ErrorHandler.error(message: "HTTP Error", statusCode: statusCode)
    }
  }
}
