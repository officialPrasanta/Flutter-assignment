import 'package:get/get.dart';
import 'package:scanstonks/models/criteria.dart';
import 'package:scanstonks/models/stockdata.dart';
import 'package:scanstonks/models/variables.dart';
import 'package:scanstonks/views/detailedpage.dart';

class MainController extends GetxController {
  List<StockData> stockDataList = <StockData>[];

  StockData detailedPageData = StockData();
  List<String> keys = <String>[];
  Rx<int> keyCursor = 0.obs;
  List values = [];
  List<String> splittedText = <String>[];
  VariablesCriterion? variablesCriterion;
  IVariable? variableType;
  int indicatorDefaultValue = 0;

  List<Map<String, dynamic>> d = [
    {
      "id": 1,
      "name": "Top gainers",
      "tag": "Intraday Bullish",
      "color": "green",
      "criteria": [
        {
          "type": "plain_text",
          "text": "Sort - %price change in descending order"
        }
      ]
    },
    {
      "id": 2,
      "name": "Intraday buying seen in last 15 minutes",
      "tag": "Bullish",
      "color": "green",
      "criteria": [
        {
          "type": "plain_text",
          "text": "Current candle open = current candle high"
        },
        {
          "type": "plain_text",
          "text": "Previous candle open = previous candle high"
        },
        {
          "type": "plain_text",
          "text": "2 previous candle’s open = 2 previous candle’s high"
        }
      ]
    },
    {
      "id": 3,
      "name": "Open = High",
      "tag": "Bullish",
      "color": "green",
      "criteria": [
        {
          "type": "variable",
          "text": "Today’s open < yesterday’s low by [A] %",
          "variable": {
            "[A]": {
              "type": "value",
              "values": [-3, -1, -2, -5, -10]
            }
          }
        }
      ]
    },
    {
      "id": 4,
      "name": "CCI Reversal",
      "tag": "Bearish",
      "color": "red",
      "criteria": [
        {
          "type": "variable",
          "text": "CCI [A] crosses below [B]",
          "variable": {
            "[A]": {
              "type": "indicator",
              "study_type": "cci",
              "parameter_name": "period",
              "min_value": 1,
              "max_value": 99,
              "default_value": 20
            },
            "[B]": {
              "type": "value",
              "values": [100, 200]
            }
          }
        }
      ]
    },
    {
      "id": 5,
      "name": "RSI Overbought",
      "tag": "Bearish",
      "color": "red",
      "criteria": [
        {
          "type": "variable",
          "text":
              "Max of last 5 days close > Max of last 120 days close by [A] %",
          "variable": {
            "[A]": {
              "type": "value",
              "values": [2, 1, 3, 5]
            }
          }
        },
        {
          "type": "variable",
          "text": "Today's Volume > prev [B] Vol SMA by [C] x",
          "variable": {
            "[A]": {
              "type": "value",
              "values": [10, 5, 20, 30]
            },
            "[B]": {
              "type": "value",
              "values": [1.5, 0.5, 1, 2, 3]
            }
          }
        },
        {
          "type": "variable",
          "text": "RSI [A] > 20",
          "variable": {
            "[A]": {
              "type": "indicator",
              "study_type": "rsi",
              "parameter_name": "period",
              "min_value": 1,
              "max_value": 99,
              "default_value": 14
            }
          }
        }
      ]
    }
  ];

  @override
  void onInit() {
    for (Map<String, dynamic> element in d) {
      stockDataList.add(StockData.fromJson(element));
    }
    super.onInit();
  }

  void goToDetailedPage(StockData stockData) {
    // print("Y=>${stockData.criteria![0] is VariablesCriterion}");
    detailedPageData = stockData;
    Get.to(
      const DetailedPage(),
      transition: Transition.upToDown,
      duration: const Duration(milliseconds: 500),
    );
  }

  customParser(text) {
    final regex = RegExp(r'\[([A-Z]+)\]');
    final matches = regex.allMatches(text);
    for (final Match m in matches) {
      keys.add(m[0]!);
    }
    splittedText = text.split(regex);
  }

  void textOperationsForVariables(ICriterion criterion) {
    keyCursor.value = 0;
    keys = [];
    variablesCriterion = criterion.toVariablesCriterion;
    String? text = variablesCriterion!.baseCriterion?.text;
    customParser(text);
  }

  void variablePreOperation(String key) {
    if (variablesCriterion!.variable![key].runtimeType == ValueList) {
      variableType = variablesCriterion!.variable![key];
      ValueList valueList = variablesCriterion!.variable![key]!.toValueList;
      values = valueList.values!;
      values.sort();
    } else if (variablesCriterion!.variable![key].runtimeType == Indicator) {
      variableType = variablesCriterion!.variable![key];
      Indicator indicator = variablesCriterion!.variable![key]!.toIndicator;
      indicatorDefaultValue = indicator.defaultValue!;
    } else {}
  }
}
