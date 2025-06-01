//
//  NavigationButton.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/12/24.
//

import SwiftUI

struct NavigationButton: View {
  
  let imageName: String
  var title: String = ""
  var badgeCount: String = "1"
  var isShowBadge: Bool = false
  var isShowBorder: Bool = false
  var action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      VStack {
        Image(systemName: imageName)
          .foregroundStyle(.primary)
          .overlay {
            ZStack {
              Circle()
                .fill(Color.red)
                .frame(width: 15, height: 15)
              Text("\(badgeCount)")
                .foregroundColor(.white)
                .font(.caption)
            }
            .offset(x: 12, y: -12)
            .opacity(isShowBadge ? 1 : 0)
          }
        if title != "" {
          Text(title)
            .font(.system(size: 12, weight: .regular))
            .foregroundStyle(.gray.opacity(0.6))
        }
      }
      .frame(width: 50, height: 50)
      .overlay {
        if isShowBorder {
          RoundedRectangle(cornerRadius: 6)
            .stroke(.gray.opacity(0.2), lineWidth: 1)
        }
      }
    }
  }
}

#Preview {
  NavigationButton(imageName: "person.fill",
                   title: "",
                   badgeCount: "1",
                   isShowBadge: true,
                   isShowBorder: true,
                   action: { })
}
