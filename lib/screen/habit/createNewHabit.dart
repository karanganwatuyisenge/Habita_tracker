import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tracker_habit/provider/HabitScreen/newHabitModel.dart';
import '../../homepage.dart';
import '../../provider/themeProvider.dart';

class NewHabit extends StatefulWidget{
  NewHabit({Key? key}) : super(key: key);

  @override
  State<NewHabit> createState() => _NewHabit();
}

class _NewHabit extends State<NewHabit>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _habitNameController = TextEditingController();
  final TextEditingController _otherController=TextEditingController();
  bool showvalue = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  String? _selectedHabitType;
  String? _selectedFrequency;
  final List<String> _habitTypes=['Monthly','Weekly','Daily'];
  final List<String> _monthValues = ['1 day', '2 days', '3 days', '4 days', '5 days','Other'];
  final List<String> _weekValues=['1 day','2 days','3 days','4 days','5 days','7 days'];

  List<String> _getFrequencyValues(){
    if(_selectedHabitType == 'Monthly'){
      return _monthValues;
    }
    else if(_selectedHabitType == 'Weekly'){
      return _weekValues;
    }
    else{
      return [];
    }

  }

  void SaveHabit(BuildContext context) async{
    setState(() {
      showvalue = true;
    });
    final habitModel=Provider.of<HabitModel>(context,listen: false);
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      try{
        User user=auth.currentUser!;
        String? email= user.email;
        final userDocRef= await FirebaseFirestore.instance
            .collection('users').where('email',isEqualTo: email)
            .limit(1).get().then((value) => value.docs.first.reference);
        final RegExp regex = RegExp(r'\d+');
        final match = regex.firstMatch(_selectedFrequency ?? '');
        int selectedFrequencyInt = match?.group(0) != null ? int.parse(match!.group(0)!) : 0;
        final match1=regex.firstMatch(_otherController.text);
        int otherSelectInt=match1?.group(0)!=null? int.parse(match1!.group(0)!):0;

        String habitPeriod;
        DateTime now = DateTime.now();
        if (_selectedHabitType == 'Monthly') {
          habitPeriod = DateFormat('yyyy-MM').format(DateTime.now());
        }
        else if (_selectedHabitType == 'Weekly') {
          int currentWeekDayOfMonth = now.weekday;
          habitPeriod = '${DateFormat('yyyy-MM').format(DateTime.now())}-$currentWeekDayOfMonth';
        }
        else {
          habitPeriod = DateFormat('yyyy-MM-dd').format(DateTime.now());
        }

        habitModel.setHabitName(_habitNameController.text);
        habitModel.setHabitFrequency(otherSelectInt);
        habitModel.setHabitType(_selectedHabitType!);

        if(_selectedHabitType=='Monthly' && _selectedFrequency=='Other'){
          await userDocRef.collection('habits').add({
            'habitName': habitModel.habitName,
            'habitType': habitModel.habitType,
            'habitFrequency': habitModel.setHabitFrequency(otherSelectInt),
            'createdAt': DateTime.now(),
            'completed': {
              if (habitPeriod != null) habitPeriod: {'count': 0, 'dates': [],
              }
            }});
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('NewHabitSavedSuccessfully'.tr())));
        }
        else if(_selectedHabitType=='Monthly' && _selectedFrequency!='Other'){
          await userDocRef.collection('habits').add({
            'habitName': habitModel.habitName,
            'habitType': habitModel.habitType,
            'habitFrequency': habitModel.setHabitFrequency(selectedFrequencyInt),
            'createdAt': DateTime.now(),
            'completed': {
              if (habitPeriod != null) habitPeriod: {'count': 0, 'dates': [],
              }
            }});
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('NewHabitSavedSuccessfully'.tr())));
        }
       else if(_selectedHabitType=='Weekly'){
          await userDocRef.collection('habits').add({
            'habitName': habitModel.habitName,
            'habitType': habitModel.habitType,
            'habitFrequency': habitModel.setHabitFrequency(selectedFrequencyInt),
            'createdAt': DateTime.now(),
            'completed': {
              if (habitPeriod != null) habitPeriod: {'count': 0, 'dates': [],
              }
            }});
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('NewHabitSavedSuccessfully'.tr())));
        }
        else if(_selectedHabitType=='Daily'){
          int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
          await userDocRef.collection('habits').add({
            'habitName': _habitNameController.text,
            'habitType': _selectedHabitType,
            'habitFrequency': daysInMonth,
            'createdAt': DateTime.now(),
            'completed': {
              if (habitPeriod != null) habitPeriod: {'count': 0, 'dates': [],
              }
            }});
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('NewHabitSavedSuccessfully'.tr())));
        }

          _habitNameController.clear();
          _otherController.clear();

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage())
        );
      }
      catch (e, stackTrace) {
        print('Error Saving data: $e\n$stackTrace');
      }
      // catch(e){
      //   print('Error Saving data: {$e}');
      // }
    }
    setState(() {
      showvalue=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final habitModel = Provider.of<HabitModel>(context, listen: false);
    return Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CreateNewHabit'.tr(),
                      style: TextStyle(fontSize: 15),
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                    ),
                    // ...
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        TextFormField(
                            controller: _habitNameController,
                            decoration: InputDecoration(
                              labelText: 'HabitName'.tr(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'PleaseEnterYourHabitName'.tr();
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          hint: Text('SelectHabitType'.tr()),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )
                          ),
                          value: _selectedHabitType,
                          onChanged: (value) {
                            setState(() {
                              _selectedHabitType = value;
                            });
                          },
                          items: _habitTypes.map((habit) {
                            return DropdownMenuItem(
                              value: habit,
                              child: Text(habit),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20,),
                        _selectedHabitType != 'Daily' ? DropdownButtonFormField(
                          hint: Text('Select times'),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )
                          ),
                          value: _selectedFrequency,
                          onChanged: (value) {
                            setState(() {
                              _selectedFrequency = value;
                            });
                          },
                          items: _getFrequencyValues().map((frequency) {
                            return DropdownMenuItem(
                              value: frequency,
                              child: Text(frequency),
                            );
                          }).toList(),
                        ) : SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        _selectedHabitType == 'Monthly' &&
                            _selectedFrequency == 'Other' ? TextFormField(
                          controller: _otherController,
                          decoration: InputDecoration(
                              labelText: 'EnterTimes'.tr(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                        ) : SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        if (showvalue) CircularProgressIndicator(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          onPressed: () {
                            SaveHabit(context);
                          },
                          child: Text('CreateNew'.tr()),
                        )
                      ],
                    ),
                  ),
                ),
              ]
          );
        });
  }
  }
