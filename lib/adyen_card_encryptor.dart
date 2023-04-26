import 'dart:async';

import 'package:flutter/services.dart';

class AdyenCardEncryptor {
  static const MethodChannel _channel = MethodChannel('adyen_card_encryptor');

  static Future<Map> encryptCardData(Map<String, dynamic> cardData) async {
    final Map encryptedCardData = await _channel.invokeMethod('encryptCardData', cardData);
    return encryptedCardData;
  }
}
