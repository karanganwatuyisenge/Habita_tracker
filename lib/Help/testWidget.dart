// import 'package:flutter/material.dart';
// import 'package:tracker_habit/Help/nameList.dart';
//
// class TestWidget extends StatefulWidget {
//   const TestWidget({Key? key}) : super(key: key);
//
//   @override
//   State<TestWidget> createState() => _TestWidgetState();
// }
//
// class _TestWidgetState extends State<TestWidget> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final List<String> _names = [];
//
//   void _saveName() {
//     setState(() {
//       _names.add(_nameController.text);
//       _nameController.clear();
//     });
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Test Widget'),),
//       body: ListView(
//         key: _formKey,
//         children: [
//           ListTile(
//             leading:  IconButton(
//               icon: Icon(Icons.list),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => NameList(names: _names),
//                   ),
//                 );
//               },
//             ),
//           ),
//           TextFormField(
//             controller: _nameController,
//             decoration: InputDecoration(
//                 labelText: 'Enter your Name',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 )
//             ),
//             validator: (value){
//               if(value?.isEmpty ?? true){
//                 return 'Please Enter your Name';
//               }
//             },
//           ),
//           ElevatedButton(
//             child: Text('Save Here'),
//             onPressed: _saveName,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:tracker_habit/Help/nameList.dart';
// // class TestWidget extends StatefulWidget {
// //   const TestWidget({Key? key}) : super(key: key);
// //
// //   @override
// //   State<TestWidget> createState() => _TestWidgetState();
// // }
// //
// // class _TestWidgetState extends State<TestWidget> {
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController _nameController = TextEditingController();
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final auth = FirebaseAuth.instance;
// //   //
// //
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Test Widget'),),
// //       body: ListView(
// //         key: _formKey,
// //         children: [
// //           ListTile(
// //             leading:  IconButton(
// //               icon: Icon(Icons.list),
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => NameList(),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //           TextFormField(
// //             controller: _nameController,
// //             decoration: InputDecoration(
// //               labelText: 'Enter your Name',
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(10),
// //               )
// //             ),
// //             validator: (value){
// //               if(value?.isEmpty ?? true){
// //                 return 'Please Enter yur Name';
// //               }
// //             },
// //           ),
// //           ElevatedButton(
// //             child: Text('Save Here'),
// //               onPressed: (){
// //               //SaveName();
// //               }
// //           ),
// //
// //         ],
// //       ),
// //     );
// //   }
// // }
// // //void SaveName() async {
// //   //   await FirebaseFirestore.instance.collection('names').add({
// //   //     'name': _nameController.text,
// //   //   });
// //   //   Navigator.push(
// //   //     context,
// //   //     MaterialPageRoute(builder: (context) => TestWidget()),
// //   //   );
// //   // }