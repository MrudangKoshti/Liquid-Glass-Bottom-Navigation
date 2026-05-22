import UIKit

struct LiquidGlassNavItemModel: Identifiable {
    let id = UUID()
    let label: String
    let sfSymbol: String?
    let selectedSfSymbol: String?
}

struct LiquidGlassNavStyleModel {
    let height: Double
    let marginHorizontal: Double
    let marginBottom: Double
    let borderRadius: Double
    let tintColor: UIColor?
    let selectedItemColor: UIColor
    let unselectedItemColor: UIColor
    let iconSize: Double
    let selectedIconSize: Double
    let showLabels: Bool
    let enableHaptics: Bool
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
