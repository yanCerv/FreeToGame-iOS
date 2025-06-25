//
//  CachedImageContent.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 23/06/25.
//

import SwiftUI

struct CachedImageContent: View {
  var imageUrl: String
  var imageId: Int
  var namespace: Namespace.ID
  
  init(imageUrl: String, imageId: Int, namespace: Namespace.ID) {
    self.imageUrl = imageUrl
    self.imageId = imageId
    self.namespace = namespace
  }
  
  var body: some View {
    CachedImage(url: URL(string: imageUrl)) { phase in
      switch phase {
      case .success(let image):
        image
          .resizable()
          .scaledToFill()
      default:
        Color.red.opacity(0.6)
      }
    }
  }
}
