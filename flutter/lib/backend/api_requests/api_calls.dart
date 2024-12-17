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
    String? baseURL = '',
    String? transferTime = '',
    String? fromAddress = '',
    String? toAddress = '',
    double? amount,
    String? notes = '',
    String? groupId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "transfer_time": "${escapeStringForJson(transferTime)}",
  "from_address": "${escapeStringForJson(fromAddress)}",
  "to_address": "${escapeStringForJson(toAddress)}",
  "amount": ${amount},
  "group_id": "${escapeStringForJson(groupId)}",
  "notes": "${escapeStringForJson(notes)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'accountTrans',
      apiUrl: '${baseURL}/account/transfer/',
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
      apiUrl: '${baseURL}/food/insert/',
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
      apiUrl: '${baseURL}/food/all/',
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
    String? paddress = '',
    String? notes = '',
  }) async {
    final ffApiRequestBody = '''
{
  "use_time": "${escapeStringForJson(useTime)}",
  "use_food_group_id": "${escapeStringForJson(groupId)}",
  "use_food_address": "${escapeStringForJson(faddress)}",
  "use_food_amount_percentage": ${amountPercentage},
  "user_address": "${escapeStringForJson(paddress)}",
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
      encodeBodyUtf8: true,
      decodeUtf8: true,
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
      apiUrl: '${baseURL}/account/all/',
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
    String? groupId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'accountSingle',
      apiUrl: '${baseURL}/account/single/',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'address': address,
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

class GetAccountTransCall {
  static Future<ApiCallResponse> call({
    String? baseURL = '',
    String? groupId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getAccountTrans',
      apiUrl: '${baseURL}/account/transfer/',
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

class JoinApiCall {
  static Future<ApiCallResponse> call({
    String? baseURL = '',
    String? name = '',
    String? address = '',
    String? joinId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}",
  "address": "${escapeStringForJson(address)}",
  "group_id": "${escapeStringForJson(joinId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'joinApi',
      apiUrl: '${baseURL}/account/join_group/',
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

class FoodSingleCall {
  static Future<ApiCallResponse> call({
    String? baseURL = '',
    String? address = '',
    String? groupId = '',
    String? timestamp = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'foodSingle',
      apiUrl: '${baseURL}/food/single/',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'address': address,
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

class FoodpieCall {
  static Future<ApiCallResponse> call({
    String? baseURL = '',
    String? groupId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'foodpie',
      apiUrl: '${baseURL}/food/pie/',
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
