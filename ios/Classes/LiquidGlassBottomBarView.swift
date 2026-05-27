import SwiftUI
import UIKit

struct LiquidGlassBottomBarView: View {
    let selectedIndex: Int
    let items: [LiquidGlassNavItemModel]
    let style: LiquidGlassNavStyleModel
    let onTap: (Int) -> Void

    @State private var dragOffsetX: CGFloat = 0
    @State private var isDraggingIndicator = false

    private var presetMultiplier: Double {
        switch style.preset {
        case 1: return 0.75
        case 2: return 1.0
        case 3: return 1.2
        default: return 1.0
        }
    }

    private var effectiveIntensity: Double {
        min(1.4, max(0.0, style.intensity * presetMultiplier))
    }

    var body: some View {
        GeometryReader { geometry in
            let count = max(items.count, 1)
            let itemWidth = geometry.size.width / CGFloat(count)
            let indicatorWidth = max(12, itemWidth - CGFloat(style.itemSpacing))
            let baseX = itemWidth * (CGFloat(selectedIndex) + 0.5)
            let clampedX = min(max(baseX + dragOffsetX, itemWidth / 2), geometry.size.width - itemWidth / 2)
            let dragNearestIndex = nearestIndex(forX: clampedX, itemWidth: itemWidth, itemCount: count)
            let activeIndex = isDraggingIndicator ? dragNearestIndex : selectedIndex

            ZStack(alignment: .leading) {
                containerGlassBackground

                if activeIndex >= 0,
                   activeIndex < items.count,
                   style.selectedStyle != .none {
                    selectedIndicator
                        .frame(width: indicatorWidth)
                        .position(x: clampedX, y: geometry.size.height / 2)
                        .animation(
                            .spring(
                                response: style.animationResponse,
                                dampingFraction: style.animationDampingFraction
                            ),
                            value: clampedX
                        )
                }

                HStack(spacing: style.itemSpacing) {
                    ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                        button(for: item, index: index, isSelected: index == activeIndex)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, style.verticalPadding)
            }
            .contentShape(Rectangle())
            .gesture(style.enableDragIndicator ? dragGesture(itemWidth: itemWidth, itemCount: count) : nil)
        }
        .frame(height: style.height)
        .padding(.horizontal, style.marginHorizontal)
        .padding(.bottom, style.marginBottom)
        .overlay(debugOverlay)
    }

    private func button(for item: LiquidGlassNavItemModel, index: Int, isSelected: Bool) -> some View {
        Button {
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
                        .font(labelFont)
                }
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .foregroundColor(itemColor(isSelected: isSelected))
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var containerGlassBackground: some View {
        let borderOpacity = min(1.0, style.containerBorderOpacity * effectiveIntensity)
        let shadowOpacity = min(0.5, style.containerShadowOpacity * effectiveIntensity)

        if #available(iOS 15.0, *) {
            let shape = Capsule(style: .continuous)
            style.containerMaterialStyle
                .fillShape(shape)
                .opacity(style.containerOpacity)
                .overlay(shape.stroke(Color.white.opacity(borderOpacity), lineWidth: 0.9))
                .overlay {
                    if let tint = style.tintColor {
                        shape.fill(Color(tint).opacity(0.08 * effectiveIntensity))
                    }
                }
                .shadow(color: Color.black.opacity(shadowOpacity), radius: 18, x: 0, y: 8)
                .shadow(color: Color.white.opacity(0.35 * effectiveIntensity), radius: 1.1, x: 0, y: 0.6)
        } else {
            Capsule(style: .continuous)
                .fill(Color(UIColor.secondarySystemBackground).opacity(0.92))
                .overlay(
                    Capsule(style: .continuous)
                        .stroke(Color(UIColor.separator).opacity(0.18), lineWidth: 0.6)
                )
        }
    }

    @ViewBuilder
    private var selectedIndicator: some View {
        if #available(iOS 15.0, *) {
            let shape = Capsule(style: .continuous)
            style.selectedMaterialStyle
                .fillShape(shape)
                .opacity(style.selectedPillOpacity)
                .overlay(
                    shape.stroke(
                        Color.white.opacity(min(1.0, style.selectedPillBorderOpacity * effectiveIntensity)),
                        lineWidth: style.selectedStyle == .bubble ? 1.0 : 0.8
                    )
                )
                .shadow(
                    color: Color.black.opacity(min(0.5, style.selectedPillShadowOpacity * effectiveIntensity)),
                    radius: style.selectedStyle == .bubble ? 16 : 12,
                    x: 0,
                    y: 5
                )
                .scaleEffect(style.selectedPillScale * (style.selectedStyle == .bubble ? 1.06 : 1.0))
                .padding(.horizontal, style.selectedPillHorizontalInset)
        } else {
            Capsule(style: .continuous)
                .fill(Color.white.opacity(0.78))
                .padding(.horizontal, style.selectedPillHorizontalInset)
        }
    }

    private func dragGesture(itemWidth: CGFloat, itemCount: Int) -> some Gesture {
        DragGesture(minimumDistance: 6)
            .onChanged { value in
                isDraggingIndicator = true
                dragOffsetX = value.translation.width
            }
            .onEnded { value in
                let baseX = itemWidth * (CGFloat(selectedIndex) + 0.5)
                let finalX = min(max(baseX + value.translation.width, itemWidth / 2), (itemWidth * CGFloat(itemCount)) - itemWidth / 2)
                let targetIndex = nearestIndex(forX: finalX, itemWidth: itemWidth, itemCount: itemCount)
                dragOffsetX = 0
                isDraggingIndicator = false
                if style.enableHaptics {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                }
                onTap(targetIndex)
            }
    }

    private func nearestIndex(forX x: CGFloat, itemWidth: CGFloat, itemCount: Int) -> Int {
        let raw = Int(round((x / itemWidth) - 0.5))
        return min(max(raw, 0), max(itemCount - 1, 0))
    }

    @ViewBuilder
    private var debugOverlay: some View {
        if style.debugShowBounds {
            RoundedRectangle(cornerRadius: style.borderRadius)
                .stroke(Color.red.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [6, 4]))
                .padding(.horizontal, style.marginHorizontal)
                .padding(.bottom, style.marginBottom)
        } else {
            Color.clear
        }
    }

    private var labelFont: Font {
        if #available(iOS 14.0, *) {
            return .caption2
        } else {
            return .caption
        }
    }

    private func itemColor(isSelected: Bool) -> Color {
        let uiColor = isSelected ? style.selectedItemColor : style.unselectedItemColor
        return Color(uiColor)
    }
}
