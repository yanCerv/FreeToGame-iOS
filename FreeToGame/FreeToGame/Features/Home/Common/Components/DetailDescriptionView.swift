//
//  DetailDescriptionView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/06/25.
//

import SwiftUI

struct DetailDescriptionView: View {
  
  var aboutGame: String
  var welcomeDescription: String
  
  var body: some View {
    VStack {
      Text(aboutGame)
        .font(.system(size: 20, weight: .semibold))
        .foregroundStyle(.secondary)
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
      
      Text(welcomeDescription)
        .font(.subheadline).fontWeight(.medium)
        .foregroundStyle(.secondary)
        .padding(.horizontal, 16)
    }
  }
}
