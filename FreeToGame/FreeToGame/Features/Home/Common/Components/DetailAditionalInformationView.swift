//
//  DetailAditionalInformationView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/06/25.
//

import SwiftUI

struct DetailAditionalInformationView: View {
  
  let gameDetail: GameDetail
  
  var body: some View {
    VStack {
      Text("Additional Information")
        .font(.system(size: 16, weight: .semibold))
        .foregroundStyle(.white.opacity(0.9))
        .padding()
      DetailAditionalContentView(gameDetail: gameDetail)
        .padding(.bottom, 16)
    }
  }
}
