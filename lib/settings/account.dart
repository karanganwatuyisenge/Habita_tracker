import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:tracker_habit/provider/themeProvider.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key:key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<Account> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _updateAccount() async {
    final user = FirebaseAuth.instance.currentUser;
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Only update fields with non-empty values
    if (name.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({'name': name});
    }

    if (email.isNotEmpty) {
      await user!.updateEmail(email);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'email': email});
    }

    if (password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        await user!.updatePassword(password);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('PasswordsDoNotMatch'.tr())));
        return;
      }
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('AccountUpdated'.tr())));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        _nameController.text = data['name'] ?? '';
        _emailController.text = user.email ?? '';
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context,themeProvider,child){
      final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor:themeProvider.isDarkMode ? Colors.black :Color(0xFFFFFFFF) ,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.black :Color(0xFFFFFFFF),
        elevation: 0,
        title: Row(
          children: [
            Text(
              'Account'.tr(),
              style: TextStyle(
                color: themeProvider.isDarkMode ? Colors.black:Color(0xff4c505b),
                fontSize: 27,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              right: 35,
              left: 35,
            ),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Expanded(
                    child: ListView(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Name'.tr(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Email'.tr(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Password'.tr(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'ConfirmPassword'.tr(),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: _updateAccount,
                          child: Text('Update'.tr()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  });
}}
