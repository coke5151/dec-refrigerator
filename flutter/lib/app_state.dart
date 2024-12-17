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
    _safeInit(() {
      _password = prefs.getStringList('ff_password') ?? _password;
    });
    _safeInit(() {
      _privatekey = prefs.getString('ff_privatekey') ?? _privatekey;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _baseURL = '';
  String get baseURL => _baseURL;
  set baseURL(String value) {
    _baseURL = value;
    prefs.setString('ff_baseURL', value);
  }

  String _groupid = '';
  String get groupid => _groupid;
  set groupid(String value) {
    _groupid = value;
    prefs.setString('ff_groupid', value);
  }

  String _myaddress = '';
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

  List<String> _password = [];
  List<String> get password => _password;
  set password(List<String> value) {
    _password = value;
    prefs.setStringList('ff_password', value);
  }

  void addToPassword(String value) {
    password.add(value);
    prefs.setStringList('ff_password', _password);
  }

  void removeFromPassword(String value) {
    password.remove(value);
    prefs.setStringList('ff_password', _password);
  }

  void removeAtIndexFromPassword(int index) {
    password.removeAt(index);
    prefs.setStringList('ff_password', _password);
  }

  void updatePasswordAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    password[index] = updateFn(_password[index]);
    prefs.setStringList('ff_password', _password);
  }

  void insertAtIndexInPassword(int index, String value) {
    password.insert(index, value);
    prefs.setStringList('ff_password', _password);
  }

  String _privatekey = '';
  String get privatekey => _privatekey;
  set privatekey(String value) {
    _privatekey = value;
    prefs.setString('ff_privatekey', value);
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
