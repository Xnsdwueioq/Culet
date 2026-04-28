//
//  ContentView.swift
//  CuletDraft
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import SwiftUI
@testable import Culet

struct ContentView: View {
  let gradientRed = Color(red: 0.5, green: 0.0, blue: 0.2)
  var body: some View {
    ZStack {
      Color(white: 1).ignoresSafeArea()
      
      VStack {
        Text("Glass Card")
          .font(.headline)
      }
      .frame(maxWidth: .infinity)
      .frame(height: 300)
      .background {
        // Свечение теперь внутри фона и обрезается вместе с ним
        ZStack {
          RadialGradient(colors: [gradientRed.opacity(0.4), .clear], center: .topLeading, startRadius: 0, endRadius: 200)
          RadialGradient(colors: [Color.pink.opacity(0.4), .clear], center: .bottomTrailing, startRadius: 0, endRadius: 200)
        }
      }
      .background(.ultraThinMaterial)
      .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
      .overlay(
        RoundedRectangle(cornerRadius: 30, style: .continuous)
          .stroke(
            LinearGradient(
              colors: [.white.opacity(0.5), .white.opacity(0.0), .white.opacity(0.2)],
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            ),
            lineWidth: 1
          )
      )
      .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 10)
      .padding(24)
    }
  }
}

struct TestView: View {
  @State private var color: Color = Color(red: 159/256, green: 0/256, blue: 15/256)
  
  var body: some View {
    GlassContainer(color: color)
      .padding()
      .frame(height: 350)
    Spacer()
    ColorPicker("Picker", selection: $color)
  }
}

struct GlassContainer: View {
  let color: Color
  
  var body: some View {
    ZStack {
      EllipticalGradient(colors: [color.opacity(0.4), color.opacity(0.6)])
      VStack {
        Text("")
          .font(.title2.bold())
          .foregroundStyle(.primary)
      }
    }
    .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
    .foregroundStyle(.ultraThinMaterial)
    .overlay(
      RoundedRectangle(cornerRadius: 50, style: .continuous)
        .stroke(.white.opacity(0.3), lineWidth: 1)
    )
  }
}

#Preview {
  ContentView()
}

#Preview {
  TestView()
}
