import 'package:clover_flutter/utils/common_widgets.dart';
import 'package:clover_flutter/utils/helper_functions.dart';
import 'package:clover_flutter/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  _ChooseLanguageScreenState createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  String _selectedLocale = 'en'; // temporarily set to english

  _ChooseLanguageScreenState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _selectedLocale = AppLocalizations.of(context)!.languageLocale;
      });
    });
  }

  _buildLanguageCard(locale) {
    final _countryCode = getCountryCodeFromLanguageCode(locale);

    return (GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(4),
            color: _selectedLocale == locale
                ? Theme.of(context).primaryColorLight
                : Colors.white),
        child: Row(
          children: [
            Row(
              children: [
                Image(
                    image: Image.asset('icons/flags/png/$_countryCode.png',
                            package: 'country_icons', scale: 2)
                        .image),
                const SizedBox(width: 10),
                Text(getLanguageNameFromLanguageCode(locale),
                    style: GoogleFonts.prompt(
                        textStyle: const TextStyle(fontSize: 18)))
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          _selectedLocale = locale;
        });
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.chooseLanguage),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildLanguageCard('en'),
                      _buildLanguageCard('hi'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              buildButton(AppLocalizations.of(context)!.confirm, () {
                SharedPreferencesHelper.setLocale(_selectedLocale);
                MyApp.of(context)!.setLocale(Locale(_selectedLocale));
              })
            ],
          ),
        ),
      ),
    );
  }
}
