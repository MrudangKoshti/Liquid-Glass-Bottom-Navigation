import Flutter
import SwiftUI
import UIKit

class LiquidGlassNavbarPlatformView: NSObject, FlutterPlatformView {
    private let containerView: UIView
    private var hostingController: UIHostingController<LiquidGlassBottomBarView>?
    private let channel: FlutterMethodChannel

    private var selectedIndex: Int
    private var items: [LiquidGlassNavItemModel]
    private var style: LiquidGlassNavStyleModel

    init(
        frame: CGRect,
        viewId: Int64,
        args: Any?,
        messenger: FlutterBinaryMessenger
    ) {
        self.containerView = UIView(frame: frame)
        self.channel = FlutterMethodChannel(
            name: "cupertino_liquid_navbar/native_navbar_\(viewId)",
            binaryMessenger: messenger
        )

        let decoded = Self.decodeArgs(args)
        self.selectedIndex = decoded.selectedIndex
        self.items = decoded.items
        self.style = decoded.style

        super.init()

        containerView.backgroundColor = .clear
        setupChannel()
        render()
    }

    func view() -> UIView {
        containerView
    }

    private func setupChannel() {
        channel.setMethodCallHandler { [weak self] call, result in
            guard let self = self else {
                result(nil)
                return
            }

            switch call.method {
            case "updateSelectedIndex":
                if let index = call.arguments as? Int {
                    self.selectedIndex = index
                    self.render()
                }
                result(nil)

            case "updateItems":
                if let rawItems = call.arguments as? [[String: Any]] {
                    self.items = Self.decodeItems(rawItems)
                    self.render()
                }
                result(nil)

            case "updateStyle":
                if let rawStyle = call.arguments as? [String: Any] {
                    self.style = Self.decodeStyle(rawStyle)
                    self.render()
                }
                result(nil)

            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    private func render() {
        let swiftUIView = LiquidGlassBottomBarView(
            selectedIndex: selectedIndex,
            items: items,
            style: style,
            onTap: { [weak self] index in
                guard let self = self else { return }
                self.selectedIndex = index
                self.channel.invokeMethod("onTap", arguments: index)
                self.render()
            }
        )

        if let hostingController = hostingController {
            hostingController.rootView = swiftUIView
            return
        }

        let controller = UIHostingController(rootView: swiftUIView)
        controller.view.backgroundColor = .clear

        containerView.addSubview(controller.view)
        controller.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            controller.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])

        hostingController = controller
    }

    private static func decodeArgs(_ args: Any?) -> (
        selectedIndex: Int,
        items: [LiquidGlassNavItemModel],
        style: LiquidGlassNavStyleModel
    ) {
        let map = args as? [String: Any] ?? [:]
        let selectedIndex = map["selectedIndex"] as? Int ?? 0
        let rawItems = map["items"] as? [[String: Any]] ?? []
        let rawStyle = map["style"] as? [String: Any] ?? [:]

        return (
            selectedIndex,
            decodeItems(rawItems),
            decodeStyle(rawStyle)
        )
    }

    private static func decodeItems(_ rawItems: [[String: Any]]) -> [LiquidGlassNavItemModel] {
        rawItems.map { item in
            LiquidGlassNavItemModel(
                label: item["label"] as? String ?? "",
                sfSymbol: item["sfSymbol"] as? String,
                selectedSfSymbol: item["selectedSfSymbol"] as? String
            )
        }
    }

    private static func decodeStyle(_ rawStyle: [String: Any]) -> LiquidGlassNavStyleModel {
        let selectedStyleRaw = rawStyle["selectedStyle"] as? Int ?? 1
        let selectedStyle = LiquidGlassSelectedStyle(rawValue: selectedStyleRaw) ?? .pill
        let containerMaterialRaw = rawStyle["containerMaterialStyle"] as? Int ?? 1
        let selectedMaterialRaw = rawStyle["selectedMaterialStyle"] as? Int ?? 2

        return LiquidGlassNavStyleModel(
            height: rawStyle["height"] as? Double ?? 72,
            marginHorizontal: rawStyle["marginHorizontal"] as? Double ?? 16,
            marginBottom: rawStyle["marginBottom"] as? Double ?? 12,
            borderRadius: rawStyle["borderRadius"] as? Double ?? 32,
            itemSpacing: rawStyle["itemSpacing"] as? Double ?? 8,
            verticalPadding: rawStyle["verticalPadding"] as? Double ?? 8,
            preset: rawStyle["preset"] as? Int ?? 0,
            selectedStyle: selectedStyle,
            intensity: rawStyle["intensity"] as? Double ?? 1.0,
            tintColor: UIColor.fromFlutterColor(rawStyle["tintColor"] as? Int),
            selectedItemColor: UIColor.fromFlutterColor(rawStyle["selectedItemColor"] as? Int) ?? .black,
            unselectedItemColor: UIColor.fromFlutterColor(rawStyle["unselectedItemColor"] as? Int) ?? .darkGray,
            iconSize: rawStyle["iconSize"] as? Double ?? 22,
            selectedIconSize: rawStyle["selectedIconSize"] as? Double ?? 24,
            showLabels: rawStyle["showLabels"] as? Bool ?? true,
            enableHaptics: rawStyle["enableHaptics"] as? Bool ?? true,
            containerMaterialStyle: LiquidGlassMaterialStyle(rawValue: containerMaterialRaw) ?? .ultraThin,
            selectedMaterialStyle: LiquidGlassMaterialStyle(rawValue: selectedMaterialRaw) ?? .thin,
            containerOpacity: rawStyle["containerOpacity"] as? Double ?? 1.0,
            containerBorderOpacity: rawStyle["containerBorderOpacity"] as? Double ?? 0.45,
            containerShadowOpacity: rawStyle["containerShadowOpacity"] as? Double ?? 0.08,
            selectedPillOpacity: rawStyle["selectedPillOpacity"] as? Double ?? 1.0,
            selectedPillBorderOpacity: rawStyle["selectedPillBorderOpacity"] as? Double ?? 0.65,
            selectedPillShadowOpacity: rawStyle["selectedPillShadowOpacity"] as? Double ?? 0.10,
            selectedPillHorizontalInset: rawStyle["selectedPillHorizontalInset"] as? Double ?? 2,
            selectedPillScale: rawStyle["selectedPillScale"] as? Double ?? 1.0,
            chromaticAberrationOpacity: rawStyle["chromaticAberrationOpacity"] as? Double ?? 0.75,
            animationResponse: rawStyle["animationResponse"] as? Double ?? 0.28,
            animationDampingFraction: rawStyle["animationDampingFraction"] as? Double ?? 0.85,
            debugShowBounds: rawStyle["debugShowBounds"] as? Bool ?? false,
            enableDragIndicator: rawStyle["enableDragIndicator"] as? Bool ?? true
        )
    }
}
