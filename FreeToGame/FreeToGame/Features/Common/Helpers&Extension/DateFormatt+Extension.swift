//
//  DateFormatt+Extension.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 01/06/25.
//

import SwiftUI

enum FormatterType: String {
  case fullDateTime = "yyyy-MM-dd h:mm a"
  case fullDate = "yyyy-MM-dd"
  case YearMonth = "yyyy-MM"
}

extension DateFormatter {
  static func formatter(type: FormatterType) -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = type.rawValue
    return formatter
  }
}
