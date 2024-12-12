import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _phrase = prefs.getStringList('ff_phrase') ?? _phrase;
    });
    _safeInit(() {
      _baseURL = prefs.getString('ff_baseURL') ?? _baseURL;
    });
    _safeInit(() {
      _groupid = prefs.getString('ff_groupid') ?? _groupid;
    });
    _safeInit(() {
      _myaddress = prefs.getString('ff_myaddress') ?? _myaddress;
    });
    _safeInit(() {
      _myName = prefs.getString('ff_myName') ?? _myName;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<String> _phrase = [];
  List<String> get phrase => _phrase;
  set phrase(List<String> value) {
    _phrase = value;
    prefs.setStringList('ff_phrase', value);
  }

  void addToPhrase(String value) {
    phrase.add(value);
    prefs.setStringList('ff_phrase', _phrase);
  }

  void removeFromPhrase(String value) {
    phrase.remove(value);
    prefs.setStringList('ff_phrase', _phrase);
  }

  void removeAtIndexFromPhrase(int index) {
    phrase.removeAt(index);
    prefs.setStringList('ff_phrase', _phrase);
  }

  void updatePhraseAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    phrase[index] = updateFn(_phrase[index]);
    prefs.setStringList('ff_phrase', _phrase);
  }

  void insertAtIndexInPhrase(int index, String value) {
    phrase.insert(index, value);
    prefs.setStringList('ff_phrase', _phrase);
  }

  String _baseURL = 'http://decentralized7.ddns.net:64214/';
  String get baseURL => _baseURL;
  set baseURL(String value) {
    _baseURL = value;
    prefs.setString('ff_baseURL', value);
  }

  String _groupid = '123';
  String get groupid => _groupid;
  set groupid(String value) {
    _groupid = value;
    prefs.setString('ff_groupid', value);
  }

  String _myaddress = '0x123';
  String get myaddress => _myaddress;
  set myaddress(String value) {
    _myaddress = value;
    prefs.setString('ff_myaddress', value);
  }

  String _myName = '';
  String get myName => _myName;
  set myName(String value) {
    _myName = value;
    prefs.setString('ff_myName', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
