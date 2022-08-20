//interface
abstract class IVariable {
  IVariable fromJson(Map<String, dynamic> json);
}

class VariableType {
  String? type;
  VariableType({this.type});
}

// 1. ValueList

class ValueList implements IVariable {
  List<dynamic>? values;
  VariableType? variableType;
  ValueList({
    String? type = '',
    this.values = const <dynamic>[],
  }) : variableType = VariableType(type: type);

  @override
  IVariable fromJson(Map<String, dynamic> json) {
    variableType?.type = json['type'] ?? '';
    values = json['values'];
    return this;
  }
}

// 2. Indicator

class Indicator implements IVariable {
  VariableType? variableType;
  String? studyType;
  String? parameterName;
  int? minValue;
  int? maxValue;
  int? defaultValue;

  Indicator({
    String? type = '',
    this.studyType = '',
    this.parameterName = '',
    this.minValue = 0,
    this.maxValue = 0,
    this.defaultValue = 0,
  }) : variableType = VariableType(type: type);

  @override
  IVariable fromJson(Map<String, dynamic> json) {
    variableType?.type = json['type'] ?? '';
    studyType = json['study_type'] ?? '';
    parameterName = json['parameter_name'] ?? '';
    minValue = json['min_value'] ?? 0;
    maxValue = json['max_value'] ?? 0;
    defaultValue = json['default_value'] ?? 0;
    return this;
  }
}

// 3. Default
class DefaultVariable implements IVariable {
  DefaultVariable();
  @override
  IVariable fromJson(Map<String, dynamic> json) {
    return this;
  }
}

extension IVariableExtension on IVariable {
  ValueList get toValueList => this as ValueList;
  Indicator get toIndicator => this as Indicator;
}
