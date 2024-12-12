// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FoodlistStruct extends BaseStruct {
  FoodlistStruct({
    double? cost,
    double? amount,
  })  : _cost = cost,
        _amount = amount;

  // "cost" field.
  double? _cost;
  double get cost => _cost ?? 0.0;
  set cost(double? val) => _cost = val;

  void incrementCost(double amount) => cost = cost + amount;

  bool hasCost() => _cost != null;

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  set amount(double? val) => _amount = val;

  void incrementAmount(double amount) => amount = amount + amount;

  bool hasAmount() => _amount != null;

  static FoodlistStruct fromMap(Map<String, dynamic> data) => FoodlistStruct(
        cost: castToType<double>(data['cost']),
        amount: castToType<double>(data['amount']),
      );

  static FoodlistStruct? maybeFromMap(dynamic data) =>
      data is Map ? FoodlistStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'cost': _cost,
        'amount': _amount,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'cost': serializeParam(
          _cost,
          ParamType.double,
        ),
        'amount': serializeParam(
          _amount,
          ParamType.double,
        ),
      }.withoutNulls;

  static FoodlistStruct fromSerializableMap(Map<String, dynamic> data) =>
      FoodlistStruct(
        cost: deserializeParam(
          data['cost'],
          ParamType.double,
          false,
        ),
        amount: deserializeParam(
          data['amount'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'FoodlistStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FoodlistStruct &&
        cost == other.cost &&
        amount == other.amount;
  }

  @override
  int get hashCode => const ListEquality().hash([cost, amount]);
}

FoodlistStruct createFoodlistStruct({
  double? cost,
  double? amount,
}) =>
    FoodlistStruct(
      cost: cost,
      amount: amount,
    );
