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

import 'package:web3dart/crypto.dart';

import 'package:web3dart/web3dart.dart';
import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;

Future<NewAccountStruct> generateAccount() async {
  final mnemonic = bip39.generateMnemonic();
  final seed = bip39.mnemonicToSeed(mnemonic);
  final root = bip32.BIP32.fromSeed(seed);
  final child1 = root.derivePath("m/44'/60'/0'/0/0");
  final privateKey = bytesToHex(child1.privateKey!.toList());
  final publicKey = await (EthPrivateKey.fromHex(privateKey)).address;
  NewAccountStruct newAccount = new NewAccountStruct(
      privateKey: privateKey,
      publicKey: publicKey.toString(),
      mnemonic: mnemonic);
  return newAccount;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
