import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../homepage.dart';

class NewHabit extends StatefulWidget{
  NewHabit({Key? key}) : super(key: key);

  @override
  State<NewHabit> createState() => _NewHabit();
}

class _NewHabit extends State<NewHabit>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController _habitNameController = TextEditingController();
  bool showvalue = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  String? _selectedHabitType;
  String? _selectedFrequency;
  String? _otherText;
  String? _selectedGoalOrHabitType;
  List<String> _goalOrHabitTypes=['Goal','Habit'];
  List<String> _habitTypes=['Monthly','Weekly','Daily'];
  List<String> _monthValues = ['1 day', '2 days', '3 days', '4 days', '5 days','Other'];
  List<String> _weekValues=['1 day','2 days','3 days','4 days','5 days','7 days'];
  List<String> _daysValues=['1 hour','2 hours','3 hours','4 hours','5 hours',
    '6 hours','7 hours','8 hours','9 hours','10 hours'];

  List<String> _getFrequencyValues(){
    if(_selectedHabitType == 'Monthly'){
      return _monthValues;
    }
    else if(_selectedHabitType == 'Weekly'){
      return _weekValues;
    }
    else if(_selectedHabitType == 'Daily'){
      return _daysValues;
    }
    else{
      return [];
    }
  }


  void SaveHabit() async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      try{
        User user=auth.currentUser!;
        String? email= user.email;

        final userDocRef= await FirebaseFirestore.instance
            .collection('users').where('email',isEqualTo: email)
            .limit(1).get().then((value) => value.docs.first.reference);

        await userDocRef.collection('habits').add({
          'habitName': _habitNameController.text,
          'habitType': _selectedHabitType,
          'habitFrequency':_selectedFrequency,
          'createdAt': DateTime.now(),
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('New Habit Saved Successfully')));
        setState(() {
          _habitNameController.clear();
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage())
        );
      }
      catch(e){
        print('Error Saving data: Se');
      }

    }
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Create New Habit', style: TextStyle(fontSize: 15),),
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
                    SizedBox(height: 20,),
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
                      hint: Text('Select Habit Type'),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                      ),
                      value: _selectedHabitType,
                      onChanged: (value){
                        setState(() {
                          _selectedHabitType=value;
                        });
                      },
                      items: _habitTypes.map((habit){
                        return DropdownMenuItem(
                          value: habit,
                          child: Text(habit),
                        );
                      }).toList(),
                        ),
                    DropdownButtonFormField(
                      hint: Text('Select $_selectedHabitType'),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                      ),
                      value: _selectedFrequency,
                      onChanged: (value){
                        setState(() {
                          if(value=='Other'){
                            _otherText='';
                          }
                          else{
                            _otherText=null;
                          }
                          _selectedFrequency=value;
                        });
                      },
                      items: _getFrequencyValues().map((frequency){
                        return DropdownMenuItem(
                          value: frequency,
                          child: Text(frequency),
                        );
                      }).toList(),
                    ),
                    // if(_selectedHabitType=='Monthly' && _selectedFrequency=='Other'){
                    //   return [
                    //     TextFormField(
                    //     decoration: InputDecoration(
                    //       labelText: 'Other',
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //     ),
                    //     onChanged: (value){
                    //       setState(() {
                    //         _otherText=value;
                    //       });
                    //     },
                    //     validator: (value){
                    //       if(value!.isEmpty){
                    //         return 'Please enter a value';
                    //       }
                    //       return null;
                    //     },
                    //   ),]
                    // },
                    SizedBox(height: 20,),
                    DropdownButtonFormField(
                      hint: Text('Select $_selectedHabitType'),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                      ),
                      value: _selectedFrequency,
                      onChanged: (value){
                        setState(() {
                          _selectedFrequency=value;
                        });
                      },
                      items: _getFrequencyValues().map((frequency){
                        return DropdownMenuItem(
                          value: frequency,
                          child: Text(frequency),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                        SaveHabit();},
                      child: const Text('Create New'),
                    )
                  ],
                ),
              ),
            ),
          ]);
  }

  }


