import 'package:JushiPayments/finance/WalletHome.dart';
import 'package:JushiPayments/utility/Localizations/localization_constants.dart';
import 'package:JushiPayments/utility/Setting_ui/settings_list.dart';
import 'package:JushiPayments/utility/Setting_ui/settings_section.dart';
import 'package:JushiPayments/utility/Setting_ui/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}


class _LanguagesScreenState extends State<LanguagesScreen> {
  int languageIndex ;
  SharedPreferences prefs;

  Locale _locale;
  @override
  void initState() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
        if(_locale.languageCode == 'en')
        {languageIndex = 0;}
        else if(_locale.languageCode == 'ar')
        {languageIndex = 1;}
        else if(_locale.languageCode == 'zh')
        {languageIndex = 2;}
      });
    });
    super.initState();
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(getTranslated(context, 'Select_Language'))),
      body: SettingsList(
        sections: [
          SettingsSection(tiles: [
            SettingsTile(
              title: getTranslated(context, "English"),
              trailing: trailingWidget(0),
              onTap: () {
                changeLanguage( getTranslated(context, "English"),0);
              },
            ),
            SettingsTile(
              title: getTranslated(context, "Arabic"),
              trailing: trailingWidget(1),
              onTap: () {
                changeLanguage(getTranslated(context, "Arabic"),1);
              },
            ),
            SettingsTile(
              title: getTranslated(context, "Chinese"),
              trailing: trailingWidget(2),
              onTap: () {
                changeLanguage(getTranslated(context, "Chinese"),2);
              },
            ),

          ]),
        ],
      ),
    );
  }

  Widget trailingWidget(int index) {
    return (languageIndex == index)
        ? Icon(Icons.check, color: Colors.blue)
        : Icon(null);
  }

  void changeLanguage(String languageCode,int index) async{
   prefs = await SharedPreferences.getInstance();
    setState(() {
      languageIndex = index;
      //prefs.setInt("Language", languageIndex);
      //prefs.commit();
    });


    Locale _temp = await setLocale(languageCode,index);
    MyApp.setLocale(context ,_temp);
    Navigator.pop(context);
  }


}