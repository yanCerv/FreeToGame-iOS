//
//  RequirementsRow.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/06/25.
//

import SwiftUI

struct RequirementsContentView: View {
  var requirements: MinimumSystemRequirements
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      RequirementRow(title: "OS:", value: requirements.os)
      RequirementRow(title: "Memory:", value: requirements.memory)
      RequirementRow(title: "Processor:", value: requirements.processor)
      RequirementRow(title: "Graphics:", value: requirements.graphics)
      RequirementRow(title: "Storage:", value: requirements.storage)
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 16)
  }
}

struct RequirementRow: View {
  let title: String
  let value: String

  var body: some View {
    HStack(spacing: 10) {
      Group {
        Text(title)
          .foregroundStyle(.white.opacity(0.8))
        Text(value)
          .foregroundStyle(.white.opacity(0.7))
      }
      .font(.system(size: 12, weight: .semibold))
    }
  }
}
