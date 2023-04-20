import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../authentication/login.dart';
import '../homepage.dart';
import '../models/language.dart';
import '../progressess/progressess.dart';
import 'account.dart';

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
    {"name": "France", "icon": '🇺🇸', "locale": const Locale('fr', 'FR')},
    {"name": "English", "icon": '🇫🇷', "locale": const Locale('en', 'US')},
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

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MyLogin()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Setting',
              style: TextStyle(fontSize: 27, color: Color(0xff4c505b))),
          elevation: 0,
        ),
        body: ListView(children: [
          ListTile(
            title: Text('Account'),
            trailing: IconButton(
              onPressed: () {
                context.setLocale(Locale('fr', 'FR'));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Account()));
              },
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ),
          const ListTile(
            title: Text('About App'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),

          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) =>
                    AlertDialog(
                      title: Text('Select Language'),
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
              title: Text('Language'),
              trailing: Icon(Icons.language),
            ),
          ),


          // ListTile(
          //   title: Text('Language'),
          //   trailing: DropdownButton<Language>(
          //     value: _selectedLanguage,
          //     onChanged: _onLanguageSelected,
          //     items: _languages
          //         .map<DropdownMenuItem<Language>>(
          //           (lang) => DropdownMenuItem<Language>(
          //         key: ValueKey(lang.countryCode), // add a unique key
          //         value: lang,
          //         child: Text(lang.name),
          //       ),
          //     )
          //         .toList(),
          //   )
          // ),
          // ListTile(
          //   title: Text('Language'),
          //   trailing: IconButton(
          //     onPressed: () {  },
          //     icon: Icon(Icons.language),),
          // ),

          // ListTile(
          //   onTap: () {
          //     showDialog(
          //         context: context,
          //         builder: (ctx) => AlertDialog(
          //               elevation: 0.0,
          //               title: Center(child: const Text("Choose a Language")),
          //               // content: ListTile(
          //               //   leading: Icon(Icons.language),
          //               //   title: lang.map((e) => ListTile(e)).toList(),
          //               // ),
          //               content: Column(
          //                 mainAxisSize: MainAxisSize.min,
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 children: [
          //                   ListTile(
          //                     title: Column(
          //                       children: lang.map((e) => Text(e)).toList(),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //         ));
          //   },
          //   title: const Text('Language'),
          //   // trailing: DropdownButton<Language>(
          //   //   value:_selectedLanguage,
          //   //   items:_languages
          //   //       .map((e) => DropdownMenuItem(value: e,
          //   //       child: Text(e.name))).toList(),
          //   //   onChanged:(newValue){
          //   //     setState(() {
          //   //       _selectedLanguage=newValue;
          //   //     });
          //   //   }
          //   // ),
          //   trailing: const Icon(Icons.language),
          // ),

          ListTile(
            title: const Text('Log Out'),
            trailing: IconButton(
              onPressed: () async {
                await _signOut(context);
              },
              icon: const Icon(Icons.logout),
            ),
          ),
        ]),

        bottomNavigationBar: Container(
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Progress()));
              },
              icon: const Icon(Icons.show_chart),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Setting()));
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.orangeAccent,
              ),
            ),
          ]),
        ));
  }
}
