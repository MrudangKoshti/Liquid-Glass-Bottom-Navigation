import Flutter
import UIKit

public class CupertinoLiquidNavbarPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let factory = LiquidGlassNavbarFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "cupertino_liquid_navbar/native_navbar")
    }
}
