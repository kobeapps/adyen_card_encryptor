import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adyen_card_encryptor/adyen_card_encryptor.dart';

void main() {
  const MethodChannel channel = MethodChannel('adyen_card_encryptor');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {});

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('tbd', () async {});
}
