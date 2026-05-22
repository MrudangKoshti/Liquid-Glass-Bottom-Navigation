import SwiftUI
import UIKit

// Reserved for future host-level composition logic.
final class LiquidGlassNavbarHostView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
}
