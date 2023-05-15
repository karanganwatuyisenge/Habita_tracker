import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../homepage.dart';
import '../../provider/GoalScreen/newGoalModel.dart';

class NewGoal extends StatefulWidget {

  NewGoal({Key? key}) : super(key: key);

  @override
  State<NewGoal> createState() => _NewGoal();
}
class _NewGoal extends State<NewGoal> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _goalNameController = TextEditingController();
  bool showvalue = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  String? _selectedGoalType;
  String? _selectedGoalOrHabitType;
  DateTime? currentDate;
  String? formattedDate;

  TextEditingController _selectEndDate = TextEditingController();

  void SaveGoal(BuildContext context) async {
    setState(() {
      showvalue = true;
    });
    final goalModel = Provider.of<GoalModel>(context, listen: false);

    var selectStartingDate = DateTime.now();
    var selectStartDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        User user = auth.currentUser!;
        String? email = user.email;

        final userDocRef = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .limit(1)
            .get()
            .then((value) => value.docs.first.reference);


        goalModel.setGoalName(_goalNameController.text);
        goalModel.setStartDate(selectStartDate);
        goalModel.setEndDate(_selectEndDate.text);

        await userDocRef.collection('goals').add({
          'goalName': goalModel.goalName,
          'startDate': goalModel.startDate,
          'endDate': goalModel.endDate,
          'completed': false,
          'createdAt': DateTime.now(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('NewGoalSavedSuccessfully'.tr())));

        _goalNameController.clear();
        _selectEndDate.clear();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        print('Error Saving Data: Se');
      }
    }
    setState(() {
      showvalue = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    currentDate = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final goalModel = GoalModel();
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'CreateNewGoal'.tr(), style: TextStyle(fontSize: 15),),
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
                      labelText: 'YourGoalName'.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'PleaseEnterYourGoal'.tr();
                      }
                      return null;
                    },
                    onChanged: (value) {
                      goalModel.setGoalName(value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "$formattedDate",
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _selectEndDate,
                    readOnly: true, // Set readOnly to true to prevent user input
                    decoration: InputDecoration(
                      labelText: 'Select End Date',
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2025),
                      );
                      if (pickedDate != null) {
                        _selectEndDate.text = DateFormat("yyyy-MM-dd").format(pickedDate);
                        _selectedGoalType = _selectEndDate.text;
                      }
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'PleaseEnterYourGoal'.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  if (showvalue) CircularProgressIndicator(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                    ),
                    onPressed: () {
                      SaveGoal(context);
                    },
                    child: Text('CreateNew').tr(),
                  ),

                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     minimumSize: Size.fromHeight(50),
                  //   ),
                  //   onPressed: (){
                  //     SaveGoal(context);
                  //   },
                  //   child: Text('CreateNew').tr(),
                  // )
                ],
              ),
            ),
          ),

        ]);

  }

}
