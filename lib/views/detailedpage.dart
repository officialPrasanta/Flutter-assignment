// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scanstonks/constants/color_code.dart';
import 'package:scanstonks/constants/measurements.dart';
import 'package:scanstonks/controllers/main_controller.dart';
import 'package:scanstonks/models/criteria.dart';
import 'package:scanstonks/models/variables.dart';
import 'package:scanstonks/views/widgets/info_card.dart';
import 'package:scanstonks/views/widgets/plaintext.dart';

class DetailedPage extends StatelessWidget {
  const DetailedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Detail Info',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(kMargin),
        child: ListView(
          children: [
            InfoCard(
              name: mainController.detailedPageData.name ?? '',
              tag: mainController.detailedPageData.tag ?? '',
              textColor: mainController.detailedPageData.color,
              bgColor: kSelectedCardColor,
              onTap: null,
            ),
            ...mainController.detailedPageData.criteria!
                .map((ICriterion criterion) {
              if (criterion.runtimeType == PlainTextCriterion) {
                PlainTextCriterion ptc = criterion.toPlainTextCriterion;
                return PlainTextWidget(plainTextCriterion: ptc);
              } else if (criterion.runtimeType == VariablesCriterion) {
                mainController.textOperationsForVariables(criterion);

                return Container(
                  padding: const EdgeInsets.all(kCardPadding),
                  margin: const EdgeInsets.only(bottom: kMargin),
                  decoration: BoxDecoration(
                    color: kCardColor,
                    borderRadius: BorderRadius.circular(kCardRadius),
                  ),
                  child: Row(
                    children: mainController.splittedText.map((splttxt) {
                      // print()
                      List<Widget> addW = <Widget>[];

                      addW.add(
                        Flexible(
                          child: Text(splttxt),
                        ),
                      );

                      if (mainController.keyCursor.value <
                          mainController.keys.length) {
                        mainController.variablePreOperation(mainController
                            .keys[mainController.keyCursor.value]);

                        if (mainController.variableType.runtimeType ==
                            ValueList) {
                          addW.add(
                            DropdownButton(
                                underline: SizedBox(),
                                isDense: true,
                                iconSize: 0.0,
                                value: mainController.values[0],
                                items: mainController.values
                                    .map(
                                      (value) => DropdownMenuItem(
                                        value: value,
                                        child: value == mainController.values[0]
                                            ? Text(
                                                '$value',
                                                style: TextStyle(
                                                    color: kSelectedCardColor),
                                              )
                                            : Text('$value'),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (dynamic newValue) {}),
                          );
                        } else if (mainController.variableType.runtimeType ==
                            Indicator) {
                          openDialogBox() {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Set Parameters"),
                                content: const TextField(),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      color: kCardColor,
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("okay"),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          addW.add(InkWell(
                            onTap: openDialogBox,
                            child: Text(
                              mainController.indicatorDefaultValue.toString(),
                              style: TextStyle(color: kSelectedCardColor),
                            ),
                          ));
                        } else {
                          addW.add(Container(
                            color: Colors.red,
                            width: 10,
                            height: 10,
                          ));
                        }
                      } else {
                        addW.add(SizedBox());
                      }
                      mainController.keyCursor.value++;

                      return Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: addW,
                        ),
                      );
                    }).toList(),
                  ),
                );
              } else {
                return Container();
              }
            }).toList(),
          ],
        ),
      ),
    );
  }
}
