// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NewAccountStruct extends BaseStruct {
  NewAccountStruct({
    String? privateKey,
    String? publicKey,
    String? mnemonic,
  })  : _privateKey = privateKey,
        _publicKey = publicKey,
        _mnemonic = mnemonic;

  // "privateKey" field.
  String? _privateKey;
  String get privateKey => _privateKey ?? '';
  set privateKey(String? val) => _privateKey = val;

  bool hasPrivateKey() => _privateKey != null;

  // "publicKey" field.
  String? _publicKey;
  String get publicKey => _publicKey ?? '';
  set publicKey(String? val) => _publicKey = val;

  bool hasPublicKey() => _publicKey != null;

  // "mnemonic" field.
  String? _mnemonic;
  String get mnemonic => _mnemonic ?? '';
  set mnemonic(String? val) => _mnemonic = val;

  bool hasMnemonic() => _mnemonic != null;

  static NewAccountStruct fromMap(Map<String, dynamic> data) =>
      NewAccountStruct(
        privateKey: data['privateKey'] as String?,
        publicKey: data['publicKey'] as String?,
        mnemonic: data['mnemonic'] as String?,
      );

  static NewAccountStruct? maybeFromMap(dynamic data) => data is Map
      ? NewAccountStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'privateKey': _privateKey,
        'publicKey': _publicKey,
        'mnemonic': _mnemonic,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'privateKey': serializeParam(
          _privateKey,
          ParamType.String,
        ),
        'publicKey': serializeParam(
          _publicKey,
          ParamType.String,
        ),
        'mnemonic': serializeParam(
          _mnemonic,
          ParamType.String,
        ),
      }.withoutNulls;

  static NewAccountStruct fromSerializableMap(Map<String, dynamic> data) =>
      NewAccountStruct(
        privateKey: deserializeParam(
          data['privateKey'],
          ParamType.String,
          false,
        ),
        publicKey: deserializeParam(
          data['publicKey'],
          ParamType.String,
          false,
        ),
        mnemonic: deserializeParam(
          data['mnemonic'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'NewAccountStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NewAccountStruct &&
        privateKey == other.privateKey &&
        publicKey == other.publicKey &&
        mnemonic == other.mnemonic;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([privateKey, publicKey, mnemonic]);
}

NewAccountStruct createNewAccountStruct({
  String? privateKey,
  String? publicKey,
  String? mnemonic,
}) =>
    NewAccountStruct(
      privateKey: privateKey,
      publicKey: publicKey,
      mnemonic: mnemonic,
    );
