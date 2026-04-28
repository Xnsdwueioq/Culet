//
//  MainBackgroundView.swift
//  CuletDraft
//

import SwiftUI

// MARK: - Color Palette
struct BackgroundPalette {
  /// `light` / `dark` — пары для каждой темы.
  
  // MARK: Base
  /// Основной нейтральный цвет — занимает большую часть сетки.
  static let baseLightPrimary   = Color(hue: 0.0, saturation: 0.0, brightness: 0.98)
  static let baseDarkPrimary    = Color(hue: 0.0, saturation: 0.0, brightness: 0.08)
  
  /// Вторичный нейтральный — чуть теплее, для плавного перехода.
  static let baseLightSecondary = Color(hue: 0.02, saturation: 0.02, brightness: 0.96)
  static let baseDarkSecondary  = Color(hue: 0.02, saturation: 0.03, brightness: 0.10)
  
  // MARK: Burgundy Accents
  /// Первый бордовый акцент — верхний-левый угол.
  /// Очень приглушённый, едва заметный.
  static let accentLightA = Color(hue: 0.95, saturation: 0.25, brightness: 0.92)
  static let accentDarkA  = Color(hue: 0.95, saturation: 0.35, brightness: 0.16)
  
  /// Второй бордовый акцент — нижний-правый угол.
  /// Чуть более насыщенный для асимметрии.
  static let accentLightB = Color(hue: 0.97, saturation: 0.20, brightness: 0.94)
  static let accentDarkB  = Color(hue: 0.97, saturation: 0.30, brightness: 0.14)
  
  /// Третий акцент — мягкий розоватый, центр-низ.
  static let accentLightC = Color(hue: 0.98, saturation: 0.12, brightness: 0.95)
  static let accentDarkC  = Color(hue: 0.98, saturation: 0.18, brightness: 0.12)
  
  // MARK: Animation Parameters
  
  /// Длительность одного цикла анимации (секунды).
  static let animationCycleDuration: Double = 4.0
  
  /// Диапазон смещения контрольных точек mesh при анимации.
  /// Чем больше — тем заметнее движение фона.
  static let meshPointDrift: Float = 0.15
}

// MARK: - Main Background View
struct MainBackgroundView: View {
  @Environment(\.colorScheme) private var colorScheme
  
  /// Переключатель для запуска анимации.
  @State private var isAnimating = false
  private var isAnimationReduced: Bool
  
  init(isAnimationReduced: Bool = false) {
    self.isAnimationReduced = isAnimationReduced
  }
  
  // MARK: - Computed Colors
  private var basePrimary: Color {
    colorScheme == .dark
    ? BackgroundPalette.baseDarkPrimary
    : BackgroundPalette.baseLightPrimary
  }
  
  private var baseSecondary: Color {
    colorScheme == .dark
    ? BackgroundPalette.baseDarkSecondary
    : BackgroundPalette.baseLightSecondary
  }
  
  private var accentA: Color {
    colorScheme == .dark
    ? BackgroundPalette.accentDarkA
    : BackgroundPalette.accentLightA
  }
  
  private var accentB: Color {
    colorScheme == .dark
    ? BackgroundPalette.accentDarkB
    : BackgroundPalette.accentLightB
  }
  
  private var accentC: Color {
    colorScheme == .dark
    ? BackgroundPalette.accentDarkC
    : BackgroundPalette.accentLightC
  }
  
  // MARK: Mesh Point Offsets
  /// Текущее смещение для анимации. Меняется между 0 и `meshPointDrift`.
  private var drift: Float {
    isAnimating ? BackgroundPalette.meshPointDrift : -BackgroundPalette.meshPointDrift
  }
  
  // MARK: Body
  var body: some View {
    MeshGradient(
      width: 3,
      height: 3,
      points: meshPoints,
      colors: meshColors,
      smoothsColors: true
    )
    .ignoresSafeArea()
    .onAppear {
      withAnimation(
        .easeInOut(duration: BackgroundPalette.animationCycleDuration)
        .repeatForever(autoreverses: true)
      ) {
        guard !isAnimationReduced else { return }
        isAnimating = true
      }
    }
  }
  
  // MARK: - Mesh Configuration
  /// 3×3 сетка контрольных точек.
  /// Угловые точки закреплены, внутренние — слегка смещаются для движения.
  ///
  /// Схема расположения:
  /// ```
  ///  [accentA]  [base]     [base]
  ///  [base]     [base]     [accentC]
  ///  [base]     [accentC]  [accentB]
  /// ```
  private var meshPoints: [SIMD2<Float>] {
    [
      // Row 0 (top)
      SIMD2<Float>(0.0, 0.0),
      SIMD2<Float>(0.5, 0.0),
      SIMD2<Float>(1.0, 0.0),
      
      // Row 1 (middle) — центральная точка с анимацией
      SIMD2<Float>(0.0, 0.5),
      SIMD2<Float>(0.5 + drift, 0.5 + drift),
      SIMD2<Float>(1.0, 0.5),
      
      // Row 2 (bottom)
      SIMD2<Float>(0.0, 1.0),
      SIMD2<Float>(0.5 - drift, 1.0),
      SIMD2<Float>(1.0, 1.0),
    ]
  }
  
  /// Цвета для каждой из 9 контрольных точек.
  /// Бордовые акценты расставлены асимметрично для естественного вида.
  private var meshColors: [Color] {
    [
      // Row 0 (top): акцент A — верхний-левый угол
      accentA,       basePrimary,   basePrimary,
      
      // Row 1 (middle): нейтраль с лёгким акцентом справа
      baseSecondary, basePrimary,   accentC,
      
      // Row 2 (bottom): акцент B — нижний-правый
      basePrimary,   accentC,       accentB,
    ]
  }
}

#Preview("Light") {
  MainBackgroundView()
    .preferredColorScheme(.light)
}

#Preview("Dark") {
  MainBackgroundView()
    .preferredColorScheme(.dark)
}

#Preview("With Content") {
  ZStack {
    MainBackgroundView()
    
    VStack(spacing: 20) {
      RoundedRectangle(cornerRadius: 16, style: .continuous)
        .fill(.ultraThinMaterial)
        .frame(height: 120)
        .overlay {
          Text("Card on Background")
            .foregroundStyle(.primary)
        }
      
      RoundedRectangle(cornerRadius: 16, style: .continuous)
        .fill(.ultraThinMaterial)
        .frame(height: 200)
        .overlay {
          Text("Another Card")
            .foregroundStyle(.primary)
        }
    }
    .padding(24)
  }
}
