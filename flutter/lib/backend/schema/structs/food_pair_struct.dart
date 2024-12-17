// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FoodPairStruct extends BaseStruct {
  FoodPairStruct({
    double? cost,
    double? leftPercentage,
  })  : _cost = cost,
        _leftPercentage = leftPercentage;

  // "cost" field.
  double? _cost;
  double get cost => _cost ?? 0.0;
  set cost(double? val) => _cost = val;

  void incrementCost(double amount) => cost = cost + amount;

  bool hasCost() => _cost != null;

  // "leftPercentage" field.
  double? _leftPercentage;
  double get leftPercentage => _leftPercentage ?? 0.0;
  set leftPercentage(double? val) => _leftPercentage = val;

  void incrementLeftPercentage(double amount) =>
      leftPercentage = leftPercentage + amount;

  bool hasLeftPercentage() => _leftPercentage != null;

  static FoodPairStruct fromMap(Map<String, dynamic> data) => FoodPairStruct(
        cost: castToType<double>(data['cost']),
        leftPercentage: castToType<double>(data['leftPercentage']),
      );

  static FoodPairStruct? maybeFromMap(dynamic data) =>
      data is Map ? FoodPairStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'cost': _cost,
        'leftPercentage': _leftPercentage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'cost': serializeParam(
          _cost,
          ParamType.double,
        ),
        'leftPercentage': serializeParam(
          _leftPercentage,
          ParamType.double,
        ),
      }.withoutNulls;

  static FoodPairStruct fromSerializableMap(Map<String, dynamic> data) =>
      FoodPairStruct(
        cost: deserializeParam(
          data['cost'],
          ParamType.double,
          false,
        ),
        leftPercentage: deserializeParam(
          data['leftPercentage'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'FoodPairStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FoodPairStruct &&
        cost == other.cost &&
        leftPercentage == other.leftPercentage;
  }

  @override
  int get hashCode => const ListEquality().hash([cost, leftPercentage]);
}

FoodPairStruct createFoodPairStruct({
  double? cost,
  double? leftPercentage,
}) =>
    FoodPairStruct(
      cost: cost,
      leftPercentage: leftPercentage,
    );
