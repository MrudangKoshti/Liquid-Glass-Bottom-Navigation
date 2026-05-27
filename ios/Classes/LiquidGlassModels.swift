import SwiftUI
import UIKit

struct LiquidGlassNavItemModel: Identifiable {
    let id = UUID()
    let label: String
    let sfSymbol: String?
    let selectedSfSymbol: String?
}

enum LiquidGlassSelectedStyle: Int {
    case none = 0
    case pill = 1
    case bubble = 2
}

enum LiquidGlassMaterialStyle: Int {
    case system = 0
    case ultraThin = 1
    case thin = 2
    case regular = 3
    case thick = 4
    case chrome = 5
}

struct LiquidGlassNavStyleModel {
    let height: Double
    let marginHorizontal: Double
    let marginBottom: Double
    let borderRadius: Double
    let itemSpacing: Double
    let verticalPadding: Double

    let preset: Int
    let selectedStyle: LiquidGlassSelectedStyle
    let intensity: Double

    let tintColor: UIColor?
    let selectedItemColor: UIColor
    let unselectedItemColor: UIColor

    let iconSize: Double
    let selectedIconSize: Double
    let showLabels: Bool
    let enableHaptics: Bool

    let containerMaterialStyle: LiquidGlassMaterialStyle
    let selectedMaterialStyle: LiquidGlassMaterialStyle

    let containerOpacity: Double
    let containerBorderOpacity: Double
    let containerShadowOpacity: Double

    let selectedPillOpacity: Double
    let selectedPillBorderOpacity: Double
    let selectedPillShadowOpacity: Double
    let selectedPillHorizontalInset: Double
    let selectedPillScale: Double
    let chromaticAberrationOpacity: Double

    let animationResponse: Double
    let animationDampingFraction: Double

    let debugShowBounds: Bool
    let enableDragIndicator: Bool
}

extension LiquidGlassMaterialStyle {
    @ViewBuilder
    func fillShape<S: Shape>(_ shape: S) -> some View {
        if #available(iOS 15.0, *) {
            switch self {
            case .system:
                shape.fill(.regularMaterial)
            case .ultraThin:
                shape.fill(.ultraThinMaterial)
            case .thin:
                shape.fill(.thinMaterial)
            case .regular:
                shape.fill(.regularMaterial)
            case .thick:
                shape.fill(.thickMaterial)
            case .chrome:
                shape
                    .fill(.ultraThinMaterial)
                    .overlay(shape.fill(Color.white.opacity(0.08)))
            }
        } else {
            shape.fill(Color(UIColor.secondarySystemBackground).opacity(0.92))
        }
    }
}

extension UIColor {
    static func fromFlutterColor(_ value: Int?) -> UIColor? {
        guard let value = value else { return nil }

        let alpha = CGFloat((value >> 24) & 0xff) / 255.0
        let red = CGFloat((value >> 16) & 0xff) / 255.0
        let green = CGFloat((value >> 8) & 0xff) / 255.0
        let blue = CGFloat(value & 0xff) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
