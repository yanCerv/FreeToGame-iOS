//
//  AssistErrorMessage.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 29/11/24.
//

import Combine

protocol AssistErrorMessage {
  func error(_ subscriber: Subscribers.Completion<ErrorHandler>) -> ErrorHandler?
}

extension AssistErrorMessage {
  func error(_ subscriber: Subscribers.Completion<ErrorHandler>) -> ErrorHandler? {
    var errorHandler: ErrorHandler?
    switch subscriber {
    case .failure(let error):
      errorHandler = ErrorHandler.error(message: error.message, statusCode: error.statusCode)
      return errorHandler
    case .finished:
      return errorHandler
    }
  }
}
