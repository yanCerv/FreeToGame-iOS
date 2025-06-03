//
//  DetailRequirementsView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/06/25.
//

import SwiftUI

struct DetailRequirementsView: View {
  
  var requirements: MinimumSystemRequirements
  
  var body: some View {
    VStack {
      Text("Minimum System Requirements")
        .font(.system(size: 16, weight: .semibold))
        .foregroundStyle(.white.opacity(0.9))
        .padding()
      RequirementsContentView(requirements: requirements)
        .padding(.bottom, 16)
    }
  }
}

#Preview {
  DetailRequirementsView(requirements: JsonResource.getResourcePreview("GameDetailMock", type: GameDetail.self)!.minimumSystemRequirements!)
}
