import 'package:flutter/material.dart';
import 'package:graduate_work/networking/api/api.dart';
import 'package:graduate_work/screens/root_tabbar_widget.dart';
import 'package:graduate_work/styles/src/color_set.dart';

import 'root_state_widgets/top_level_providers.dart';
import 'root_state_widgets/widgets_binding_handler.dart';

void main() async {
  try {
    final aboutCompany = await RestClient.shared.fetchAboutCompanyInfo();
    StandardColorSet.light = StandardColorSet.light.copyWith(
      barNavigation: aboutCompany.primaryColor,
      primary: aboutCompany.primaryColor,
    );
    StandardColorSet.dark = StandardColorSet.dark.copyWith(
      barNavigation: aboutCompany.primaryColor,
      primary: aboutCompany.primaryColor,
    );
  } catch (e) {}

  runApp(const TopLevelProviders(
    child: WidgetsBindingHandler(
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Best template',
      debugShowCheckedModeBanner: false,
      home: RootTabBarWidget(),
    );
  }
}

Future<void> _updateColors() async {
  final aboutCompany = await RestClient.shared.fetchAboutCompanyInfo();

  StandardColorSet.light = StandardColorSet.light.copyWith(
    barNavigation: aboutCompany.primaryColor,
  );
  StandardColorSet.dark = StandardColorSet.dark.copyWith(
    barNavigation: aboutCompany.primaryColor,
  );
}
