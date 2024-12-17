import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';

double shareprice(
  double price,
  double rate,
) {
  price ??= 0;
  rate ??= 0;
  // num = num ?? 0;
  return (price * rate) / 100;
}

double divider(
  double target,
  double divide,
) {
  return target / divide;
}

List<double>? extractValue(List<dynamic>? json) {
  // return the  name from the  json
  if (json == null) {
    return null;
  }

  List<double> labels = [];
  for (var item in json) {
    if (item is Map<String, dynamic> && item.containsKey('rate')) {
      labels.add(item['rate']);
    }
  }

  return labels.isNotEmpty ? labels : null;
}

List<String>? extractlabel(List<dynamic>? json) {
  // return the  name from the  json
  if (json == null) {
    return null;
  }

  List<String> labels = [];
  for (var item in json) {
    if (item is Map<String, dynamic> && item.containsKey('name')) {
      labels.add(item['name']);
    }
  }

  return labels.isNotEmpty ? labels : null;
}

List<String> addIndex(List<String> target) {
  List<String> result = [];
  for (int i = 0; i < target.length; i++) {
    result.add((i + 1).toString() + ". " + target[i]);
  }
  return result;
}

bool detectLastWord(String target) {
  if (target.endsWith('/')) {
    return true;
  } else {
    return false;
  }
}
