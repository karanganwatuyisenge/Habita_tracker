// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class Help extends StatefulWidget{
//   Help({Key? key}):  super(key: key);
//
//   @override
//   State<Help> createState() => _Help();
// }
//
// class _Help extends State<Help> {
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   User user=FirebaseAuth.instance.currentUser!;
//   final TextEditingController _habitTypeController =TextEditingController();
//   final TextEditingController _habitFrequencyController =TextEditingController();
//   final TextEditingController _habitNameController = TextEditingController();
//
//   Future<void> _update([DocumentSnapshot? documentSnapshot]) async{
//     if(documentSnapshot !=null){
//       _habitNameController.text=documentSnapshot['habitName'];
//       _habitTypeController.text=documentSnapshot['habitType'];
//
//       _habitFrequencyController.text =documentSnapshot['habitFrequency'];
//     }
//     await showModalBottomSheet(
//         isScrollControlled:true,
//         context: context,
//         builder: (BuildContext cont){
//           return Padding(
//             padding: EdgeInsets.only(
//                 top:20,
//                 left: 20,right: 20,
//                 bottom: MediaQuery.of(cont).viewInsets.bottom +20
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextField(
//                   controller: _habitNameController,
//                   decoration: InputDecoration(labelText: 'Habit Name'),
//                 ),
//                 TextField(
//                   controller: _habitTypeController,
//                   decoration: InputDecoration(labelText: 'Habit Type'),
//                 ),
//                 TextField(
//                   controller: _habitFrequencyController,
//                   decoration: InputDecoration(labelText: 'Habit Frequency'),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 ElevatedButton(
//                   child: Text('Update'),
//                   onPressed: () async {
//                     await _firestore
//                         .collection('users')
//                         .doc(widget.userId)
//                         .collection('habits')
//                         .doc(widget.habitId)
//                         .update({
//                       'habitName': _habitNameController.text,
//                       'habitType': _habitTypeController.text,
//                       'habitFrequency': _habitFrequencyController.text,
//                     },
//                     );
//                   }),
//             ]),
//           );
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
//         stream: FirebaseFirestore.instance.collection('users')
//             .doc(user.uid).collection('habits').snapshots(),
//         builder: (context, streamSnapshot){
//           if(streamSnapshot.connectionState==ConnectionState.waiting){
//             return const Center(child: CircularProgressIndicator());
//           }if(streamSnapshot.hasError){
//             print(streamSnapshot.error);
//             return Center(child: Text("There is an error: ${streamSnapshot.error}"));
//           }
//           else if(streamSnapshot.hasData){
//             var habits=streamSnapshot.data!.docs;
//
//             return habits.isEmpty?const Center(child: Text("No habits yet")): ListView.builder(
//                 itemCount: streamSnapshot.data!.docs.length,
//                 itemBuilder: (context,index){
//                   final DocumentSnapshot documentSnapshot=streamSnapshot.data!.docs[index];
//                   return Card(
//                     margin: const EdgeInsets.all(10),
//                     child: ListTile(
//                       title: Text(documentSnapshot['goalName']),
//                       subtitle: Text(documentSnapshot['habitName']),
//                       trailing:SizedBox(width: 100,
//                         // child: Row(
//                         //   children: [
//                         //     IconButton(
//                         //       icon:const Icon(Icons.edit),
//                         //       onPressed: () => _update(documentSnapshot.id),),
//                         //
//                         //   ],
//                         // ),
//                       ),
//
//                     ),
//                   );
//                 });
//           }
//           else{
//             return const CircularProgressIndicator();
//           }
//
//         },
//       ),
//     );
//   }
// }
//
