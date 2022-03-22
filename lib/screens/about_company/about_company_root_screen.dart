import 'package:flutter/material.dart';
import 'package:graduate_work/models/about_company_info.dart';
import 'package:graduate_work/networking/api/api.dart';
import 'package:graduate_work/screens/about_company/components/logo_widget.dart';
import 'package:graduate_work/screens/settings/settings_root_screen.dart';
import 'package:graduate_work/widgets/standard/src/app_bar.dart';
import 'package:graduate_work/widgets/standard/src/scaffold.dart';
import 'package:graduate_work/widgets/standard/src/text.dart';

class AboutCompanyRootScreen extends StatefulWidget {
  const AboutCompanyRootScreen({Key? key}) : super(key: key);

  @override
  _AboutCompanyRootScreenState createState() => _AboutCompanyRootScreenState();
}

class _AboutCompanyRootScreenState extends State<AboutCompanyRootScreen> {
  @override
  Widget build(BuildContext context) {
    return StandardScaffold.standard(
        context: context,
        appBar: StandardAppBar.standard(
            context: context,
            title: const StandardText('About'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  child: const Icon(Icons.settings, size: 30),
                  onTap: () => _showSettings(context),
                ),
              ),
            ]),
        body: FutureBuilder<AboutCompanyInfo?>(
          future: fetchInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: StandardText('Ошибка загрузки'));
            }
            if (snapshot.data != null) {
              return _buildMainListView(snapshot.data!);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  void _showSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SettingsRootScreen()),
    );
  }

  Future<AboutCompanyInfo?> fetchInfo() async {
    try {
      final info = await RestClient.shared.fetchAboutCompanyInfo();
      return info;
    } catch (error) {
      return null;
    }
  }

  Widget _buildMainListView(AboutCompanyInfo info) => ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        children: [
          Align(
            alignment: Alignment.center,
            child: LogoWidget(logoUrl: info.logoImage),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: StandardText(
              info.name,
              style: const TextStyle(fontSize: 25),
            ),
          ),
          const SizedBox(height: 16),
          StandardText(
            'Адрес: ${info.address}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          StandardText(
            info.description,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      );
}