import Flutter
import UIKit

import Adyen

public class SwiftAdyenCardEncryptorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "adyen_card_encryptor", binaryMessenger: registrar.messenger())
    let instance = SwiftAdyenCardEncryptorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "encryptCardData":
        handleEncryptCardData(call: call, result: result)
    default:
        result(FlutterMethodNotImplemented)
    }
  }

  private func handleEncryptCardData(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let cardNumber = args["cardNumber"] as? String,
          let expiryMonth = args["expiryMonth"] as? String,
          let expiryYear = args["expiryYear"] as? String,
          let cvc = args["cvc"] as? String,
          let publicKey = args["publicKey"] as? String else {
        result(FlutterError(code: "INVALID_ARGUMENTS", message: "One or more arguments are missing", details: nil))
        return
    }

    do {
        let card = Card(number: cardNumber, securityCode: cvc, expiryMonth: expiryMonth, expiryYear: expiryYear)
        let encryptedCard = try CardEncryptor.encrypt(card: card, with: publicKey)

        let encryptedCardData: [String: String?] = [
            "encryptedCardNumber": encryptedCard.number,
            "encryptedExpiryMonth": encryptedCard.expiryMonth,
            "encryptedExpiryYear": encryptedCard.expiryYear,
            "encryptedSecurityCode": encryptedCard.securityCode
        ]
        result(encryptedCardData)
    } catch {
        result(FlutterError(code: "ENCRYPTION_ERROR", message: error.localizedDescription, details: nil))
    }
}
}
