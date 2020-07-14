import 'package:JushiPayments/login.dart';
import 'package:JushiPayments/utility/Localizations/localization_constants.dart';
import 'package:JushiPayments/utility/Setting_ui/change_password.dart';
import 'package:JushiPayments/utility/Setting_ui/settings_list.dart';
import 'package:JushiPayments/utility/Setting_ui/settings_section.dart';
import 'package:JushiPayments/utility/Setting_ui/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'languages_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;
  String _code;
  Locale _locale;
  @override
  void initState() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
        if(_locale.languageCode == 'en')
          {_code = "English";}
        else if(_locale.languageCode == 'ar')
        {_code = "عربى";}
        else if(_locale.languageCode == 'zh')
        {_code = "Chinese";}
      });
    });
    super.initState();
  }
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
        if(_locale.languageCode == 'en')
        {_code = "English";}
        else if(_locale.languageCode == 'ar')
        {_code = "عربى";}
        else if(_locale.languageCode == 'zh')
        {_code = "Chinese";}
      });
    });
    super.didChangeDependencies();
  }

  SharedPreferences prefs;


  signOut() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString("txt_Emp_ID", null);
      prefs.setString("txt_Emp_Password", null);
      prefs.setString("Name", null);
      prefs.setBool("Login", false);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f4f7),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Localize',
            tiles: [
              SettingsTile(
                title: 'Language',
                //subtitle: 'English',
                subtitle:  _code,
                leading: Icon(Icons.language),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LanguagesScreen()));
                },
              ),
//              SettingsTile(
//                  title: 'Environment',
//                  subtitle: 'Production',
//                  leading: Icon(Icons.cloud_queue)),
            ],
          ),
          SettingsSection(
            title: 'Account',
            tiles: [
              SettingsTile(title: 'Password', leading: Icon(Icons.security),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => change_password()));
                  },
                ),
              //SettingsTile(title: 'Phone number', leading: Icon(Icons.phone)),
              //SettingsTile(title: 'Email', leading: Icon(Icons.email)),
              SettingsTile(title: 'Sign out', leading: Icon(Icons.exit_to_app),onTap: (){
                signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login() ));
              },),
            ],
          ),
//          SettingsSection(
//            title: 'Security',
//            tiles: [
//              SettingsTile.switchTile(
//                title: 'Lock app in background',
//                leading: Icon(Icons.phonelink_lock),
//                switchValue: lockInBackground,
//                onToggle: (bool value) {
//                  setState(() {
//                    lockInBackground = value;
//                    notificationsEnabled = value;
//                  });
//                },
//              ),
//              SettingsTile.switchTile(
//                  title: 'Use fingerprint',
//                  leading: Icon(Icons.fingerprint),
//                  onToggle: (bool value) {},
//                  switchValue: false),
//              SettingsTile.switchTile(
//                title: 'Change password',
//                leading: Icon(Icons.lock),
//                switchValue: true,
//                onToggle: (bool value) {},
//              ),
//              SettingsTile.switchTile(
//                title: 'Enable Notifications',
//                enabled: notificationsEnabled,
//                leading: Icon(Icons.notifications_active),
//                switchValue: true,
//                onToggle: (value) {},
//              ),
//            ],
//          ),
//          SettingsSection(
//            title: 'Misc',
//            tiles: [
//              SettingsTile(
//                  title: 'Terms of Service', leading: Icon(Icons.description)),
//              SettingsTile(
//                  title: 'Open source licenses',
//                  leading: Icon(Icons.collections_bookmark)),
//            ],
//          )
        ],
      ),
    );
  }
}