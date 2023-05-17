import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../authentication/login.dart';
import '../homepage.dart';
import '../models/language.dart';
import 'account.dart';
import 'package:provider/provider.dart';
import 'package:tracker_habit/provider/themeProvider.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _MySettingState();
}

class _MySettingState extends State<Setting> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<Language> _languages = [
    Language(name: 'English', icon: '🇺🇸'),
    Language(name: 'French', icon: '🇫🇷'),
    //Language(name: 'Kinyarwanda', icon: '🇷🇼'),
  ];
  Language? _selectedLanguage;

  var language = [
    {"name": "France", "icon": '🇫🇷' ,"locale": const Locale('fr', 'FR')},
    {"name": "English", "icon": '🇺🇸', "locale": const Locale('en', 'US')},
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = EasyLocalization.of(context)!.locale;
    print(locale.languageCode);
    if (_languages.isNotEmpty) {
      _selectedLanguage = _languages.firstWhere(
            (lang) => lang.name == locale.languageCode,
        orElse: () => _languages[0],
      );
    }
  }

  Future<void> _changeLanguage(BuildContext context, Locale locale) async {
    final provider = EasyLocalization.of(context)!;
    await provider.setLocale(locale);
    setState(() {
      _selectedLanguage =
          _languages.firstWhere((lang) => lang.name == locale.languageCode);
    });
  }

  Future<bool?> _showLogoutDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _signOut(BuildContext context) async {
    bool? shouldLogout = await _showLogoutDialog(context);
    if (shouldLogout == true) {
      await _auth.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyLogin()),
            (route) => false,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context,themeProvider,child){
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor:themeProvider.isDarkMode ? Colors.black :Color(0xFFFFFFFF) ,
          title: Text('Setting'.tr(),
              style: TextStyle(fontSize: 27,color: themeProvider.isDarkMode ? Color(0xFFFFFFFF):Colors.black)),
          elevation: 0,
        ),
      body: ListView(children: [

        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Account()),
            );
          },
          child: ListTile(
            title: Text('Account'.tr()),
            trailing: IconButton(
              onPressed: () {
                //context.setLocale(Locale('fr', 'FR'));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Account()),
                );
              },
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
          },
          child: ListTile(
            title: Text('AboutApp'.tr()),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),

        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) =>
                  AlertDialog(
                    title: Text('SelectLanguage'.tr()),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: language.map((lang) {
                        return RadioListTile<String>(
                          title: Row(
                            children: [
                              Text("${lang["name"]}"),
                              const Spacer(),
                              Text("${lang["icon"]}"),
                            ],
                          ),
                          value: (lang["locale"] as Locale).languageCode,
                          groupValue: context.locale.languageCode,
                          onChanged: (value) {
                            print("Kigali: ${context.locale.languageCode}");
                            context.setLocale(lang["locale"] as Locale);
                            // context.setLocale(_selectedLanguage)
                            // print("Locale : ${value!.name.toLowerCase()}");
                            // _changeLanguage(context, Locale(value!.name.toLowerCase()));
                            Navigator.pop(context);
                          },
                        );
                      }).toList(),
                    ),
                  ),
            );
          },
          child: ListTile(
            title: Text('Language'.tr()),
            trailing: Icon(Icons.language),
          ),
        ),

        ListTile(
          title: Text('LightDarkTheme'.tr()),
          trailing: Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) => Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.setTheme(value);
              },
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
            _signOut(context);
          },
          child: ListTile(
            title: Text('Logout'),
            trailing: IconButton(
              onPressed: () => _signOut(context),
              icon: Icon(Icons.logout),
            ),
          ),
        )
      ]),

      bottomNavigationBar: Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  icon: const Icon(Icons.home),
                ),
                // IconButton(
                //   onPressed: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => SeeAllHabit()));
                //   },
                //   icon: const Icon(Icons.show_chart),
                // ),
                IconButton(
                  onPressed: () {
                  },
                  icon: Icon(Icons.settings,color: themeProvider.isDarkMode?Colors.blue:Colors.orangeAccent,),
                ),
              ] ),
      ),
          );
  });
}
}
