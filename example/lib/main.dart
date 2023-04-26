import 'package:flutter/material.dart';
import 'dart:async';

import 'package:adyen_card_encryptor/adyen_card_encryptor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _encryptAndSendCardData() async {
    try {
      Map<String, dynamic> cardData = {
        'cardNumber': '5555555555554444',
        'expiryMonth': '03',
        'expiryYear': '2030',
        'cvc': '737',
        'publicKey':
            '10001|D94FDF63177B552F605E9123F754387CF69AC2654D01DEA6BD37677D02B3D20F0DAD01292AA51F5C8AEA8FEA624C67BEC2613989D644C741BCCBE0C9EF6F4EC2782FE50F6C66F71291FAB0CE8C8EE0D96FF36C54FA7A1A14DE798C2390152E188A10DC40F0F0B0E6199B55524D036DC245B5A8C037CE75933CB1D2790C6C80B13D4842F91DA08C5C8432AA19CF161F125C13D42478BF3F2DB812A8C0BCBD54509BDA6B0E53ABB0ADD7BF71F994FAE105911D9FEE2776BD7D313824DCAF52E509DC580262DFD6E03F02AE4F24B578E6DCDB540C67E01DA3739B590FD7354CD98031871CAF694498F3070ECCA739F5610F1CB4D8B9A7ADA3E045457C02A04659D3',
      };

      Map encryptedCardData = await AdyenCardEncryptor.encryptCardData(cardData);
      debugPrint("Encrypted card data: $encryptedCardData");

      // Now you can send the encrypted card data to your server
    } catch (e) {
      debugPrint("Error encrypting card data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: TextButton(
            onPressed: () async => await _encryptAndSendCardData(),
            child: const Text('Encrypt Example Card Data'),
          ),
        ),
      ),
    );
  }
}
