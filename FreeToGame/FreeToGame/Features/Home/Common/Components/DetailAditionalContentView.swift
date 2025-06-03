//
//  DetailAditionalContentView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/06/25.
//

import SwiftUI

struct DetailAditionalContentView: View {
  let gameDetail: GameDetail
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      RequirementRow(title: "Title:", value: gameDetail.title)
      RequirementRow(title: "Developer:", value: gameDetail.developer)
      RequirementRow(title: "Publisher:", value: gameDetail.publisher)
      RequirementRow(title: "Release Date:", value: gameDetail.releaseDate)
      RequirementRow(title: "Genre:", value: gameDetail.genre)
      RequirementRow(title: "Platform:", value: gameDetail.platform)
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 16)
  }
}
