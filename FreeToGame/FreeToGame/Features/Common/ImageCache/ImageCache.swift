//
//  ImageCache.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/06/25.
//

import SwiftUI

struct CachedImage<Content>: View where Content: View {
  
  private let url: URL?
  private let content: (AsyncImagePhase) -> Content

  init(url: URL? = nil, @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
    self.url = url
    self.content = content
  }

  var body: some View {
    Group {
      if let url = url,
         let cached = ImageCache.shared[url] {
        content(.success(cached))
      }
      else {
        AsyncImage(url: url) { phase in
          cachedRender(phase)
        }
      }
    }
  }
  
  private func cachedRender(_ phase: AsyncImagePhase) -> Content {
    if case .success(let img) = phase,
       let url = url
    {
      ImageCache.shared[url] = img
    }
    return content(phase)
  }
}

@MainActor
private class ImageCache {
  static let shared = ImageCache()
  private var cache: [URL: Image] = [:]

  subscript(_ url: URL) -> Image? {
    get { cache[url] }
    set { cache[url] = newValue }
  }
}
