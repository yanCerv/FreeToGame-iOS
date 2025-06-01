//
//  Content.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 02/12/24.
//

import SwiftUI

struct ContentView<T: View>: View {
  
  private let loaderState: LoaderState
  private let content: T
  
  var body: some View {
    
    switch loaderState {
    case .startLoading:
      ZStack {
        LinearGradient(colors: [.black, .gray], startPoint: .top, endPoint: .bottom)
          .ignoresSafeArea()
        LoaderView()
          .toolbar(.hidden, for: .navigationBar)
          .toolbar(.hidden, for: .tabBar)
          .tint(.white)
      }
    case .finishLoading:
      ZStack {
        LinearGradient(colors: [.black, .gray], startPoint: .top, endPoint: .bottom)
          .ignoresSafeArea()
        content
          .navigationBarTitleDisplayMode(.inline)
          .navigationBarBackButtonHidden(true)
      }
    }
  }
  
  //MARK: - Init
  
  init(loaderState: LoaderState = .finishLoading, @ViewBuilder content: () -> T) {
      self.loaderState = loaderState
      self.content = content()
  }
}

#Preview {
  ContentView(loaderState: .startLoading) { }
}
