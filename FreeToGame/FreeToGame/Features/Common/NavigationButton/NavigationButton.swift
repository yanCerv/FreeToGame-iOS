//
//  NavigationButton.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/12/24.
//

import SwiftUI

struct NavigationButton: View {
  let imageName: String
  var action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      Image(systemName: imageName)
        .foregroundStyle(.secondary)
    }
  }
}

#Preview {
  NavigationButton(imageName: "person.fill",
                   action: { } )
}
