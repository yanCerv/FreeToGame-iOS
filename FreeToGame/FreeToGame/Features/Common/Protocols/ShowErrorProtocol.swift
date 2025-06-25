//
//  ServiceError.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 01/06/25.
//

import Foundation

//  This protocol defines a strategy for handling errors and converting them into user-friendly messages.
//  Types conforming to this protocol can override the default behavior to customize error presentation.
protocol ShowErrorProtocol {
  func handled(_ error: Error) -> String
}

extension ShowErrorProtocol {
  func handled(_ error: Error) -> String {
    if let error = error as? ErrorHandler {
      return error.message
    }
    return (error as? LocalizedError)?.errorDescription ?? "Unexpected error occurred"
  }
}
