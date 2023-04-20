import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../homepage.dart';
import 'package:tracker_habit/test/mock_firestore.dart';
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

  void SaveGoal() async {
    var _selectStartingDate = DateTime.now();
    var _selectStartDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
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

        await userDocRef.collection('goals').add({
          'goalName': _goalNameController.text,
          'startDate': _selectStartDate,
          'endDate': _selectEndDate.text,
          'completed': false,
          'createdAt': DateTime.now(),
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('NewGoalSavedSuccessfully')));

        setState(() {
          _goalNameController.clear();
          _selectEndDate.clear();
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        print('Error Saving Data: Se');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    currentDate = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

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
                      labelText: "SelectEndDate".tr(),
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
                    child: const Text('CreateNew').tr(),
                  )
                ],
              ),
            ),
          ),

        ]);

  }

}

