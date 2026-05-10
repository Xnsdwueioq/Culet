//
//  MedcardCreatedView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 10.05.2026.
//

import SwiftUI

struct MedcardCreatedView: View {
  var creationDate: String
  
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      // MARK: Date
      Text(creationDate)
        .foregroundStyle(.secondary)
        .padding(.horizontal)
        .bold()
      
      // MARK: Title
      HStack {
        Image(systemName: "person.text.rectangle")
          .foregroundStyle(.brand)
        Text("Медкарта создана")
          .bold()
        Spacer()
      }
        .padding()
        .glassEffect(.clear, in: .rect(cornerRadius: 25))
    }
  }
}

#Preview {
  ZStack {
    MainBackgroundView(isAnimationReduced: true)
    
  }
}
