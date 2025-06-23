//
//  ImageContainerView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 17/06/25.
//

import SwiftUI

struct ImageContainerView: View {
  
  @State private var isTapped: Bool = false
  
  var body: some View {
    VStack {
      if isTapped {
        Spacer()
      }

      Image("X")
        .resizable()
        .clipShape(RoundedRectangle(cornerRadius: isTapped ? 0 : 18))
        .frame(
          width: isTapped ? UIScreen.main.bounds.width : .infinity,
          height: isTapped ? UIScreen.main.bounds.height : 200
        )
        .scaleEffect(isTapped ? 1.0 : 0.8)
        .animation(.spring(response: 0.5, dampingFraction: 1), value: isTapped)
        .onTapGesture {
          isTapped.toggle()
        }
        .ignoresSafeArea()

      if !isTapped {
        Spacer()
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding()
  }
}

#Preview {
    ImageContainerView()
}
