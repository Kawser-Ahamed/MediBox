// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;

// class EncryptionDemo extends StatefulWidget {
//   @override
//   _EncryptionDemoState createState() => _EncryptionDemoState();
// }

// class _EncryptionDemoState extends State<EncryptionDemo> {
  

//   String encryptedText = '';
//   String decryptedText = '';

//   TextEditingController textEditingController = TextEditingController();
//     Random random = Random();
//     String secretKey = '';

//   void keyGenerator(){
//     for(int i=1;i<=16;i++){
//       int digit = random.nextInt(10);
//       secretKey+=digit.toString();
//     } 
//   }
//   void encryptText() {
//     keyGenerator();
//     final encrypt.Key key = encrypt.Key.fromUtf8(secretKey); // Replace with your own secret key
//     final encrypt.IV iv = encrypt.IV.fromLength(16);
//     final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
//     final plainText = textEditingController.text;
//     final encrypted = encrypter.encrypt(plainText, iv: iv);

//     setState(() {
//       encryptedText = encrypted.base64;
//     });
//   }

//   void decryptText() {
//     final encrypt.Key key = encrypt.Key.fromUtf8(secretKey);
//     final encrypt.IV iv = encrypt.IV.fromLength(16);
//     final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
//     final encrypted = encrypt.Encrypted.fromBase64(encryptedText);
//     final decrypted = encrypter.decrypt(encrypted, iv: iv);

//     setState(() {
//       decryptedText = decrypted;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Text Encryption and Decryption'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             TextField(
//               controller: textEditingController,
//               decoration: InputDecoration(labelText: 'Enter Text to Encrypt'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: encryptText,
//               child: Text('Encrypt Text'),
//             ),
//             SizedBox(height: 16.0),
//             Text('Encrypted Text: $encryptedText'),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: decryptText,
//               child: Text('Decrypt Text'),
//             ),
//             SizedBox(height: 16.0),
//             Text('Decrypted Text: $decryptedText'),
//           ],
//         ),
//       ),
//     );
//   }
// }
