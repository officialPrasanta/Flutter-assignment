// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanstonks/constants/color_code.dart';
import 'package:scanstonks/constants/measurements.dart';

class InfoCard extends StatelessWidget {
  InfoCard({
    Key? key,
    this.name = "",
    this.tag = "",
    this.textColor,
    this.bgColor,
    this.onTap,
  }) : super(key: key);

  String? name;
  String? tag;
  Color? textColor;
  Color? bgColor;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(kCardRadius),
          elevation: 2,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kCardRadius),
            ),
            onTap: onTap,
            child: Ink(
              padding: const EdgeInsets.all(kCardPadding),
              decoration: BoxDecoration(
                color: bgColor ?? kCardColor,
                borderRadius: BorderRadius.circular(kCardRadius),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name ?? '',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$tag',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: kListDividerHeight,
        )
      ],
    );
  }
}
