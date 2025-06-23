//
//  EmptyStateView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 23/06/25.
//

import SwiftUI

struct EmptyStateView: View {
  
  var title: String
  
  init(title: String = "Unavailable Content") {
    self.title = title
  }
  
  var body: some View {
    VStack {
      Image(systemName: "eye.slash")
        .foregroundStyle(.secondary)
        .padding(.bottom, 6)
      Text(title)
        .font(.system(size: 18, weight: .semibold))
        .foregroundStyle(.secondary)
        .padding(.horizontal, 16)
    }
    .frame(height: 70)
    .background(Color.gray.opacity(0.5))
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .padding(8)
  }
}

#Preview {
  EmptyStateView()
}
