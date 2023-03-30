// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class FetchData extends StatefulWidget {
//   //final String userId;
//
//   FetchData({Key? key}) : super(key: key);
//
//   @override
//   _FetchDataState createState() => _FetchDataState();
// }
//
// class _FetchDataState extends State<FetchData> {
//   final auth = FirebaseAuth.instance;
//
//   retrieveData() async{
//     User user=auth.currentUser!;
//     String? email= user.email;
//
//     var result=await FirebaseFirestore.instance
//         .collection('users').doc().collection('habits')
//         .where("email",isEqualTo:email).get();
//
//     print(result.docs.length);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//     );
//   }
// }



// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
//
//
// class FetchData extends StatefulWidget{
//   FetchData({Key? key}):  super(key: key);
//
//   @override
//   State<FetchData> createState() => _FetchData();
// }
//
// class _FetchData extends State<FetchData>{
//   final currentUser = FirebaseAuth.instance;
//   final CollectionReference _habits=FirebaseFirestore.instance.collection('habits');
//   final TextEditingController _goalNameController =TextEditingController();
//   final TextEditingController _habitNameController = TextEditingController();
//
//   Future<void> _update([DocumentSnapshot? documentSnapshot]) async{
//     if(documentSnapshot !=null){
//     _goalNameController.text=documentSnapshot['goalName'];
//     _habitNameController.text=documentSnapshot['habitName'].toString();
//   }
//   await showModalBottomSheet(
//       isScrollControlled:true,
//       context: context,
//       builder: (BuildContext cont){
//         return Padding(
//             padding: EdgeInsets.only(
//               top:20,
//               left: 20,right: 20,
//               bottom: MediaQuery.of(cont).viewInsets.bottom +20
//             ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 controller: _goalNameController,
//                 decoration: InputDecoration(labelText: 'Goal Name'),
//               ),
//               TextField(
//                 controller: _habitNameController,
//                 decoration: InputDecoration(labelText: 'Habit Name'),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                 child: Text('Update'),
//                   onPressed: () async{
//                   final String goalName=_goalNameController.text;
//                   final String habitName=_habitNameController.text;
//                   await _habits.doc(documentSnapshot!.id)
//                       .update({"goalName":goalName , "habitName":habitName});
//                   _goalNameController.text='';
//                   _habitNameController.text='';
//                   },
//                   )
//             ],
//           ),
//         );
//       });
//   }
//
//   Future<void> _delete(String habitsId) async{
//     await _habits.doc(habitsId).delete();
//
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content:Text('Yo have successfully deleted a habit') ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         // stream: FirebaseFirestore.instance
//         //     .collection('users')
//         //     .doc("")
//         //     .collection('habits')
//         //     .snapshots(),
//         // builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//         stream: _habits.snapshots(),
//         builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
//           if(streamSnapshot.hasData){
//             return ListView.builder(
//               itemCount: streamSnapshot.data!.docs.length,
//               itemBuilder: (context,index){
//                 final DocumentSnapshot documentSnapshot=
//                     streamSnapshot.data!.docs[index];
//                 return Card(
//                   margin: EdgeInsets.all(10),
//                   child: ListTile(
//                     title: Text(documentSnapshot['goalName']),
//                     subtitle: Text(documentSnapshot['habitName'].toString()),
//                     trailing: SizedBox(width:100,
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.edit),
//                             onPressed: () =>
//                           _update(documentSnapshot),
//                            ),
//                         IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () =>
//                               _delete(documentSnapshot.id),
//                         ),
//                       ],
//                     ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//           else{
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//
//         },
//       ),
//     );
//   }
//   }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HabitWidget extends StatefulWidget {
  final String userId;
  final String habitId;

  HabitWidget({required this.userId, required this.habitId});

  @override
  _HabitWidgetState createState() => _HabitWidgetState();
}

class _HabitWidgetState extends State<HabitWidget> {
  String _habitName = '';

  @override
  void initState() {
    super.initState();
    _loadHabit();
  }

  Future<void> _loadHabit() async {
    final habitRef = FirebaseFirestore.instance.collection('users').doc(widget.userId).collection('habits').doc(widget.habitId);
    final snapshot = await habitRef.get();
    if (snapshot.exists) {
      setState(() {
        _habitName = snapshot.data()!['name'];
      });
    }
  }

  Future<void> _updateHabitName(String newName) async {
    final habitRef = FirebaseFirestore.instance.collection('users').doc(widget.userId).collection('habits').doc(widget.habitId);
    await habitRef.update({
      'name': newName,
    });
    setState(() {
      _habitName = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: _habitName,
          onChanged: (newName) => _updateHabitName(newName),
        ),
        Text(_habitName),
      ],
    );
  }
}
