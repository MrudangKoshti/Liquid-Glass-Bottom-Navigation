import SwiftUI
import UIKit

struct LiquidGlassBottomBarView: View {
    let selectedIndex: Int
    let items: [LiquidGlassNavItemModel]
    let style: LiquidGlassNavStyleModel
    let onTap: (Int) -> Void

    var body: some View {
        HStack(spacing: 8) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                button(for: item, index: index)
            }
        }
        .padding(.horizontal, 12)
        .frame(height: style.height)
        .background(backgroundView)
        .padding(.horizontal, style.marginHorizontal)
        .padding(.bottom, style.marginBottom)
    }

    private func button(for item: LiquidGlassNavItemModel, index: Int) -> some View {
        let isSelected = index == selectedIndex

        return Button {
            if style.enableHaptics {
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
            }
            onTap(index)
        } label: {
            VStack(spacing: 4) {
                Image(systemName: isSelected
                    ? (item.selectedSfSymbol ?? item.sfSymbol ?? "circle.fill")
                    : (item.sfSymbol ?? "circle")
                )
                .font(
                    .system(
                        size: isSelected ? style.selectedIconSize : style.iconSize,
                        weight: isSelected ? .semibold : .regular
                    )
                )

                if style.showLabels {
                    Text(item.label)
                        .font(.caption2)
                }
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(
                Color(uiColor: isSelected ? style.selectedItemColor : style.unselectedItemColor)
            )
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var backgroundView: some View {
        if #available(iOS 26.0, *) {
            // Keep iOS 26+ behavior compile-safe; if the SDK lacks glassEffect,
            // this remains a material fallback and can be swapped when available.
            RoundedRectangle(cornerRadius: style.borderRadius)
                .fill(.regularMaterial)
        } else {
            RoundedRectangle(cornerRadius: style.borderRadius)
                .fill(.regularMaterial)
        }
    }
}
