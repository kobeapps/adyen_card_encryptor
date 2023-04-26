import Flutter
import UIKit

public class SwiftAdyenCardEncryptorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "adyen_card_encryptor", binaryMessenger: registrar.messenger())
    let instance = SwiftAdyenCardEncryptorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
