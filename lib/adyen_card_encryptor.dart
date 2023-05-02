import 'dart:async';

import 'package:flutter/services.dart';

class AdyenCardEncryptor {
  static const MethodChannel _channel = MethodChannel('adyen_card_encryptor');

  static Future<Map> encryptCardData({
    required String cardNumber,
    required String expiryMonth,
    required String expiryYear,
    required String cvc,
    required String publicKey,
  }) async {
    final cardDataMap = {
      'cardNumber': cardNumber,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'cvc': cvc,
      'publicKey': publicKey,
    };
    try {
      final Map encryptedCardData = await _channel.invokeMethod('encryptCardData', cardDataMap);
      return encryptedCardData;
    } catch (e) {
      rethrow;
    }
  }
}
