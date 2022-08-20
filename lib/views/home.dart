// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scanstonks/constants/measurements.dart';
import 'package:scanstonks/controllers/main_controller.dart';
import 'package:scanstonks/models/stockdata.dart';
import 'package:scanstonks/views/widgets/info_card.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Scan Stonks',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(kMargin),
        child: ListView(
          clipBehavior: Clip.none,
          children: mainController.stockDataList.map((StockData stockData) {
            return InfoCard(
              name: stockData.name ?? '',
              tag: stockData.tag ?? '',
              textColor: stockData.color,
              onTap: () => mainController.goToDetailedPage(stockData),
            );
          }).toList(),
        ),
      ),
    );
  }
}





//  ListView(
//           children: cc.variablesCriterion is VariablesCriterion
//               ? cc.variablesCriterion.toVariablesCriterion.variable?.entries
//                       .map((element) {
//                     if (element.value.runtimeType == ValueList) {
//                       ValueList valueList = element.value as ValueList;
//                       return Container(
//                         margin: EdgeInsets.only(bottom: kMargin),
//                         padding: EdgeInsets.all(kCardPadding),
//                         decoration: BoxDecoration(
//                             color: Colors.blue,
//                             borderRadius: BorderRadius.circular(kCardRadius)),
//                         child: Column(
//                           children: [
//                             Text(valueList.variableType?.type ?? ''),
//                             InkWell(
//                               onTap: cc.showValues,
//                               child: Text(
//                                 '${valueList.values?[0]}',
//                                 style: GoogleFonts.poppins(
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFF254E70),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       );
//                     } else if (element.value.runtimeType == Indicator) {
//                       Indicator indicator = element.value as Indicator;
//                       return Container(
//                         margin: EdgeInsets.only(bottom: kMargin),
//                         padding: EdgeInsets.all(kCardPadding),
//                         decoration: BoxDecoration(
//                             color: Colors.blue,
//                             borderRadius: BorderRadius.circular(kCardRadius)),
//                         child: Column(
//                           children: [
//                             Text(indicator.variableType?.type ?? ''),
//                             InkWell(
//                               onTap: cc.showValues,
//                               child: Text(
//                                 '${indicator.defaultValue}',
//                                 style: GoogleFonts.poppins(
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFF254E70),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       );
//                     } else {
//                       return Container(
//                         child: Text('None'),
//                       );
//                     }
//                     // return Container(
//                     //   margin: EdgeInsets.only(bottom: kMargin),
//                     //   padding: EdgeInsets.all(kCardPadding),
//                     //   decoration: BoxDecoration(
//                     //       color: Colors.blue,
//                     //       borderRadius: BorderRadius.circular(kCardRadius)),
//                     //   child: Column(
//                     //     children: [
//                     //       Text(element.variableType?.type ?? ''),
//                     //       InkWell(
//                     //         onTap: cc.showValues,
//                     //         child: Text(
//                     //           '${element.values?[0]}',
//                     //           style: GoogleFonts.poppins(
//                     //             fontWeight: FontWeight.bold,
//                     //             color: Color(0xFF254E70),
//                     //           ),
//                     //         ),
//                     //       )
//                     //     ],
//                     //   ),
//                     // );
//                   }).toList() ??
//                   []
//               : [],
//         ),