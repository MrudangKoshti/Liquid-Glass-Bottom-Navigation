import Flutter
import UIKit

public class CupertinoLiquidNavbarPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let factory = LiquidGlassNavbarFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "cupertino_liquid_navbar/native_navbar")

        let capabilitiesChannel = FlutterMethodChannel(
            name: "cupertino_liquid_navbar/capabilities",
            binaryMessenger: registrar.messenger()
        )
        capabilitiesChannel.setMethodCallHandler { call, result in
            guard call.method == "getCapabilities" else {
                result(FlutterMethodNotImplemented)
                return
            }

            result([
                "supportsMaterial": true,
                "supportsAdvancedCompositing": true,
                "supportsSymbolEffects": {
                    if #available(iOS 17.0, *) { return true }
                    return false
                }(),
            ])
        }
    }
}
