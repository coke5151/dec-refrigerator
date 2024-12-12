import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class AccountTransCall {
  static Future<ApiCallResponse> call({
    String? baseURL = 'http://decentralized7.ddns.net:64214',
    String? transferTime = '',
    String? fromAddress = '',
    String? toAddress = '',
    int? amount,
    String? notes = '',
  }) async {
    final ffApiRequestBody = '''
{
  "transfer_time": "${escapeStringForJson(transferTime)}",
  "from_address": "${escapeStringForJson(fromAddress)}",
  "to_address": "${escapeStringForJson(toAddress)}",
  "amount": ${amount},
  "notes": "${escapeStringForJson(notes)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'accountTrans',
      apiUrl: '${baseURL}/account/transfer',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FoodInsertsCall {
  static Future<ApiCallResponse> call({
    String? baseURL = '',
    String? name = '',
    String? insertTime = '',
    String? dueDate = '',
    int? moneyCost = 0,
    String? buyerAddress = '',
    String? note = '\"\"',
    String? groupid = '\"\"',
  }) async {
    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}",
  "insert_time": "${escapeStringForJson(insertTime)}",
  "due_date": "${escapeStringForJson(dueDate)}",
  "money_cost": ${moneyCost},
  "buyer_address": "${escapeStringForJson(buyerAddress)}",
  "group_id": "${escapeStringForJson(groupid)}",
  "notes": "${escapeStringForJson(note)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'foodInserts',
      apiUrl: '${baseURL}/food/insert',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FoodallCall {
  static Future<ApiCallResponse> call({
    String? baseURL = '',
    String? groupid = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'foodall',
      apiUrl: '${baseURL}/food/all',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'group_id': groupid,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FooduseCall {
  static Future<ApiCallResponse> call({
    String? baseURL = '',
    String? useTime = '',
    String? groupId = '',
    String? faddress = '',
    double? amountPercentage,
    List<String>? paddressList,
    String? notes = '',
  }) async {
    final paddress = _serializeList(paddressList);

    final ffApiRequestBody = '''
{
  "use_time": "${escapeStringForJson(useTime)}",
  "use_food_group_id": "${escapeStringForJson(groupId)}",
  "use_food_address": "${escapeStringForJson(faddress)}",
  "use_food_amount_percentage": ${amountPercentage},
  "participant_addresses": ${paddress},
  "notes": "${escapeStringForJson(notes)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'fooduse',
      apiUrl: '${baseURL}/food/use/',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AccountallCall {
  static Future<ApiCallResponse> call({
    String? baseURL = '',
    String? groupId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'accountall',
      apiUrl: '${baseURL}/account/all',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'group_id': groupId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? account(dynamic response) => getJsonField(
        response,
        r'''$["account"]''',
        true,
      ) as List?;
  static dynamic accountName(dynamic response) => getJsonField(
        response,
        r'''$["account-name"]''',
      );
  static dynamic accountAddress(dynamic response) => getJsonField(
        response,
        r'''$["account-address"]''',
      );
}

class AccountSingleCall {
  static Future<ApiCallResponse> call({
    String? baseURL = '',
    String? address = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'accountSingle',
      apiUrl: '${baseURL}/account/single',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'address': address,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetAccountTransCall {
  static Future<ApiCallResponse> call({
    String? baseURL = '',
    String? groupId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getAccountTrans',
      apiUrl: '${baseURL}/account/transfer',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'group_id': groupId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
