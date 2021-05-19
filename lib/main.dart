import 'package:JushiPayments/finance/WalletHome.dart';

import 'package:JushiPayments/utility/utils.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:JushiPayments/utility/Localizations/DemoLocalizations.dart';
import 'package:JushiPayments/utility/Localizations/localization_constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';

//import 'transition_route_observer.dart';

// app icon
//flutter pub run flutter_launcher_icons:main
void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(systemNavigationBarColor: SystemUiOverlayStyle.dark.systemNavigationBarColor,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  static void setLocale(BuildContext context , Locale locale){
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocal(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences prefs;

  bool IsLogin  = false;

  Locale _locale;

  _checkIsLogin() async {
    prefs= await SharedPreferences.getInstance();
    bool _IsLogin =  (prefs.getBool("Login") ?? false);

    setState(() {
      IsLogin = _IsLogin;
      prefs.getInt('txt_Emp_ID').toString() == prefs.getString('txt_Emp_Password') ? Utils.NeedChangePassword = true : Utils.NeedChangePassword = false;
    });

  }

  void setLocal(Locale locale){
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }
@override
  void initState() {
    _checkIsLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       localizationsDelegates: [
         // ... app-specific localization delegate[s] here
         DemoLocalizations.delegate,
         GlobalMaterialLocalizations.delegate,
         GlobalWidgetsLocalizations.delegate,
         GlobalCupertinoLocalizations.delegate,
       ],
       locale: _locale,
       supportedLocales: [
         const Locale('en', 'US'), // English, no country code
         const Locale('ar', 'EG'), // Hebrew, no country code
         const Locale.fromSubtags(languageCode: 'zh',countryCode: 'HK'), // Chinese *See Advanced Locales below*
// ... other locales the app supports
       ],
       localeResolutionCallback: (deviceLocal , supportedLocals){
       for(var local in supportedLocals)
       {
         if(local.languageCode == deviceLocal.languageCode && local.countryCode  == deviceLocal.countryCode)
         {
           return deviceLocal;
         }
       }
     },
       title: 'Payments',
       theme: ThemeData(
         primarySwatch: Colors.blue,
       ),
       home: !IsLogin  ? Login() : WalletHome(EmpName: prefs.getString("Name"),) ,
       debugShowCheckedModeBanner: false,
     );
  }
}

