
import 'dart:async';

import 'package:flutter/services.dart';

class AdyenCardEncryptor {
  static const MethodChannel _channel = MethodChannel('adyen_card_encryptor');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
