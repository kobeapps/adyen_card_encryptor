package com.example.adyen_card_encryptor

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import com.adyen.checkout.cse.CardEncrypter
import com.adyen.checkout.cse.EncryptedCard
import com.adyen.checkout.cse.UnencryptedCard

/** AdyenCardEncryptorPlugin */
class AdyenCardEncryptorPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "adyen_card_encryptor")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
                "encryptCardData" -> {
                    try {
                        val cardNumber = call.argument<String>("cardNumber")
                        val expiryMonth = call.argument<String>("expiryMonth")
                        val expiryYear = call.argument<String>("expiryYear")
                        val cvc = call.argument<String>("cvc")
                        val publicKey = call.argument<String>("publicKey")

                        if (cardNumber == null || expiryMonth == null || expiryYear == null || cvc == null || publicKey == null) {
                            result.error("INVALID_ARGUMENTS", "One or more arguments are missing", null)
                        }

                        val unencryptedCard = UnencryptedCard.Builder()
                            .setNumber(cardNumber!!)
                            .setExpiryMonth(expiryMonth!!)
                            .setExpiryYear(expiryYear!!)
                            .setCvc(cvc!!)
                            .build()

                        val encryptedCard: EncryptedCard = CardEncrypter.encryptFields(
                            unencryptedCard,
                            publicKey!!
                        )

                        val encryptedCardData: Map<String, String?> = mapOf(
                            "encryptedCardNumber" to encryptedCard.encryptedCardNumber,
                            "encryptedExpiryMonth" to encryptedCard.encryptedExpiryMonth,
                            "encryptedExpiryYear" to encryptedCard.encryptedExpiryYear,
                            "encryptedSecurityCode" to encryptedCard.encryptedSecurityCode
                        )
                        result.success(encryptedCardData)
                    } catch (e: Exception) {
                        result.error("ENCRYPTION_ERROR", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
