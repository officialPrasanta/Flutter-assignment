import 'package:scanstonks/models/variables.dart';

abstract class ICriterion {
  ICriterion fromJson(Map<String, dynamic> json);
}

class BaseCriterion {
  String? type;
  String? text;
  BaseCriterion({
    this.type,
    this.text,
  });
}

//1.plain_text
class PlainTextCriterion implements ICriterion {
  BaseCriterion? baseCriterion;
  PlainTextCriterion({
    String? type = "",
    String? text = "",
  }) : baseCriterion = BaseCriterion(type: type, text: text);

  @override
  ICriterion fromJson(Map<String, dynamic> json) {
    baseCriterion?.type = json['type'];
    baseCriterion?.text = json['text'];

    return this;
  }
}

//2. variables
class VariablesCriterion implements ICriterion {
  BaseCriterion? baseCriterion;
  Map<String, IVariable>? variable = {};
  ValueList? _valueList;
  Indicator? _indicator;
  DefaultVariable? _defaultVariable;
  // RandomString? randStr = RandomString(len: 5);
  VariablesCriterion({String? type = "", String? text = "", this.variable})
      : baseCriterion = BaseCriterion(type: type, text: text);

  @override
  ICriterion fromJson(Map<String, dynamic> json) {
    baseCriterion?.type = json['type'] ?? '';
    baseCriterion?.text = json['text'] ?? '';
    if (json['variable'] != null) {
      variable = <String, IVariable>{};
      json['variable'].forEach((k, v) {
        if (v['type'] == 'value') {
          _valueList = ValueList();
          variable?[k] = _valueList!.fromJson(v);
        } else if (v['type'] == 'indicator') {
          _indicator = Indicator();
          variable?[k] = _indicator!.fromJson(v);
        } else {
          variable?[k] = _defaultVariable!.fromJson(v);
        }
      });

      // variable?[k] = (v['type'] == 'value'
      //     ? _valueList.fromJson(v)
      //     : v['type'] == 'indicator'
      //         ? _indicator.fromJson(v)
      //         : null)!);
    }

    return this;
  }
}

// 3. Default
class DefaultCriterion implements ICriterion {
  DefaultCriterion();
  @override
  ICriterion fromJson(Map<String, dynamic> json) {
    return this;
  }
}

extension ICriterionExtension on ICriterion {
  VariablesCriterion get toVariablesCriterion => this as VariablesCriterion;
  PlainTextCriterion get toPlainTextCriterion => this as PlainTextCriterion;
}
