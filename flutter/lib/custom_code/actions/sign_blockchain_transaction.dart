// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:web3dart/web3dart.dart';
import 'package:web3dart/credentials.dart';
import 'dart:typed_data';
import 'package:convert/convert.dart';

// 輔助函數
Uint8List hexToBytes(String hexString) {
  if (hexString.startsWith('0x')) {
    hexString = hexString.substring(2);
  }
  if (hexString.length % 2 != 0) {
    hexString = '0' + hexString;
  }
  var result = Uint8List(hexString.length ~/ 2);
  for (var i = 0; i < hexString.length; i += 2) {
    result[i ~/ 2] = int.parse(hexString.substring(i, i + 2), radix: 16);
  }
  return result;
}

String bytesToHex(Uint8List bytes) {
  return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}

Future<String> signBlockchainTransaction(String privateKey, String data) async {
  try {
    // 移除 0x 前綴（如果有的話）
    final cleanPrivateKey =
        privateKey.startsWith('0x') ? privateKey.substring(2) : privateKey;

    // 創建憑證
    final credentials = EthPrivateKey.fromHex(cleanPrivateKey);

    // 將資料轉換為 bytes
    final messageBytes = hexToBytes(data);

    // 簽名
    final signature = await credentials.signPersonalMessage(messageBytes);

    // 返回簽名結果
    return '0x${bytesToHex(signature)}';
  } catch (e) {
    throw Exception('簽署失敗: $e');
  }
}
