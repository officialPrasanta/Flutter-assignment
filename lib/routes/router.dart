// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:scanstonks/views/detailedpage.dart';
import 'package:scanstonks/views/home.dart';

List<GetPage> routers = <GetPage>[
  GetPage(
    name: '/HOME',
    page: () => Home(),
  ),
  GetPage(
    name: '/DETAILED_PAGE',
    page: () => DetailedPage(),
  ),
];
