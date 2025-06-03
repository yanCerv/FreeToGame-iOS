//
//  CorneredWithBorderButtonStyle.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/06/25.
//

import SwiftUI

struct DetailCorneredButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 16)
      .font(.system(size: 12, weight: .semibold))
      .frame(height: 30)
      .background(Color.blue.opacity(0.9))
      .cornerRadius(8)
      .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white.opacity(0.9), lineWidth: 1))
      .foregroundColor(Color.white.opacity(0.9))
      .opacity(configuration.isPressed ? 0.6 : 1.0)
  }
}
