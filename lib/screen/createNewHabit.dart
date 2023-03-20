import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../homepage.dart';

class NewGoalHabit extends StatefulWidget{
  NewGoalHabit({Key? key}) : super(key: key);

  @override
  State<NewGoalHabit> createState() => _NewGoalHabit();
}

class _NewGoalHabit extends State<NewGoalHabit>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController _goalNameController = TextEditingController();
  TextEditingController _habitNameController = TextEditingController();
  List<String> items = <String>[
    'January', 'February', 'March', 'April', 'May',
  ];
  String _selectedPeriod = 'January';
  List<String> type = <String>[
    'Everyday',
    '1 day per week',
    '2 days per week',
    '3 days per week',
    '4 days per week',
    '5 days per week'
  ];
  String _selectedHabit = 'Everyday';
  bool showvalue = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;


  Future<String?> _saveForm() async {
    String _goalName = _goalNameController.text;
    String _habitName = _habitNameController.text;
    String _period = _selectedPeriod;
    String _habitType = _selectedHabit;
    var user=FirebaseAuth.instance.currentUser;
    String userId = user!.uid;


    await saveNewHabit(userId);
    _goalNameController.clear();
    _habitNameController.clear();
    _period = 'January';
    _habitType = 'Everyday';

    return userId;
  }

  Future<void> saveNewHabit(String userId) async {
    try {
      DocumentReference docRef = await FirebaseFirestore.instance.collection(
          'habits')
          .add({
        'userId': userId,
        'goalName': _goalNameController.text,
        'habitName': _habitNameController.text,
        'period': _selectedPeriod,
        'habitType': _selectedHabit,
      });
      print('Data Saved Successfully');
    } catch (e) {
      print('Error Saving data: $e');
    }
  }

  //retriesve(){FirebaseFirestore.instance.collection("habits").snapshots()
  //}
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Create New Habit Goal', style: TextStyle(fontSize: 15),),
              IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
            ],
          ),

          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: _goalNameController,
                        decoration: InputDecoration(
                          labelText: 'Your Goal',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your goal';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: _habitNameController,
                        decoration: InputDecoration(
                          labelText: 'Habit Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your Habit Name';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                        value: _selectedPeriod,
                        items: items.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),);
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedPeriod = newValue!;
                          });
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                        value: _selectedHabit,
                        items: type.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),);
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedHabit = newValue!;
                          });
                        }),
                    const SizedBox(
                      height: 20,
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      onPressed: () async {
                        String? userId = await _saveForm();
                        await saveNewHabit(userId!);
                      },
                      child: const Text('Create New'),
                    )
                  ],
                ),
              ),
            ),

          ]),
    );
  }

  }

