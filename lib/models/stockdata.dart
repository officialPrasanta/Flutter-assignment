// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:scanstonks/constants/color_code.dart';
import 'package:scanstonks/models/criteria.dart';

class StockData {
  int? id;
  String? name;
  String? tag;
  Color? color;
  List<ICriterion>? criteria;
  PlainTextCriterion? _plainTextCriterion;
  VariablesCriterion? _variablesCriterion;
  DefaultCriterion? _defaultCriterion;

  StockData({this.id, this.name, this.tag, this.color, this.criteria});

  StockData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tag = json['tag'];
    color = json['color'] == 'red'
        ? kBearishColor
        : json['color'] == 'green'
            ? kBullishColor
            : kDefaultTextColor;
    if (json['criteria'] != null) {
      criteria = <ICriterion>[];
      json['criteria'].forEach((criterion) {
        if (criterion['type'] == 'plain_text') {
          _plainTextCriterion = PlainTextCriterion();
          criteria!.add(_plainTextCriterion!.fromJson(criterion));
        } else if (criterion['type'] == 'variable') {
          _variablesCriterion = VariablesCriterion();
          criteria!.add(_variablesCriterion!.fromJson(criterion));
        } else {
          _defaultCriterion = DefaultCriterion();
          criteria!.add(_defaultCriterion!);
        }
      });
    }
  }
}
