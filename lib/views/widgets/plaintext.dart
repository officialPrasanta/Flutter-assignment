import 'package:flutter/material.dart';
import 'package:scanstonks/constants/color_code.dart';
import 'package:scanstonks/constants/measurements.dart';
import 'package:scanstonks/models/criteria.dart';

class PlainTextWidget extends StatelessWidget {
  const PlainTextWidget({
    Key? key,
    required this.plainTextCriterion,
  }) : super(key: key);

  final PlainTextCriterion plainTextCriterion;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(kCardPadding),
          margin: const EdgeInsets.only(bottom: kMargin),
          decoration: BoxDecoration(
            color: kCardColor,
            borderRadius: BorderRadius.circular(kCardRadius),
          ),
          child: Text('${plainTextCriterion.baseCriterion?.text}'),
        ),
      ],
    );
  }
}
