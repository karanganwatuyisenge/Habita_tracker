import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../homepage.dart';

class NewGoal extends StatefulWidget{
  NewGoal({Key? key}) : super(key: key);

  @override
  State<NewGoal> createState() => _NewGoal();
}

class _NewGoal extends State<NewGoal>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController _goalNameController = TextEditingController();
  bool showvalue = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  String? _selectedGoalType;
  String? _selectedGoalOrHabitType;
  DateTime? currentDate;
  String? formattedDate;

  TextEditingController _selectEndDate=TextEditingController();

  void SaveGoal() async{
    var _selectStartingDate=DateTime.now();
    var _selectStartDate=DateFormat('d MMMM yyyy').format(_selectStartingDate!);
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      try{
        User user=auth.currentUser!;
        String? email= user.email;

        final userDocRef= await FirebaseFirestore.instance
            .collection('users').where('email',isEqualTo: email)
            .limit(1).get().then((value) => value.docs.first.reference);

        await userDocRef.collection('goals').add({
          'goalName': _goalNameController.text,
          'startDate':_selectStartDate,
          'endDate':_selectEndDate.text,
          'completed':false,
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('New Goal Saved Successfully')));

        setState(() {
          _goalNameController.clear();
          _selectEndDate.clear();
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
    currentDate = DateTime.now();
    formattedDate = DateFormat(' d MMMM yyyy').format(currentDate!);

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Create New Goal', style: TextStyle(fontSize: 15),),
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
                        labelText: 'Your Goal Name',
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
                    readOnly: true,
                    decoration: InputDecoration(
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "$formattedDate",
                    ),

                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _selectEndDate,
                    decoration: InputDecoration(
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Select End Date",
                      suffixIcon: Icon(Icons.calendar_today_outlined),
                    ),
                    onTap: () async{
                      DateTime? pickedDate= await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2025),
                      );
                      if(pickedDate !=null){
                        setState(() {
                          _selectEndDate.text = DateFormat("yyyy-MM-dd").format(pickedDate);
                          _selectedGoalType=_selectEndDate.text;
                        });
                      }
                    },

                  ),
                  SizedBox(height: 20,),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      SaveGoal();},
                    child: const Text('Create New'),
                  )
                ],
              ),
            ),
          ),

        ]);

  }

}

