// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:tracker_habit/screen/Goal/createNewGoal.dart';
//
//
// class MockFirestore extends Mock implements FirebaseFirestore{}
//
// void main(){
//   group('SaveGoal', () {
//     late NewGoal saveGoal;
//     late MockFirestore mockFirestore;
//
//     setUp(() {
//       mockFirestore=MockFirestore();
//       saveGoal = NewGoal(mockFirestore: mockFirestore);
//     });
//     test('Should add a new goal to firestore', () async{
//
//       when(mockFirestore.collection('users')
//           .where('email',isEqualTo: anyNamed('isEqualTo')))
//           .thenAnswer((_) => Future.value(QuerySnapshotMock()));
//       when(mockFirestore.collection('goals').add(any))
//           .thenAnswer((_) => => Future.value(DocumentReferenceMock()));
//
//       final goalName= 'Goal Name';
//       final selectEndDate='2023-06-02';
//       final formKey=GlobalKey<FormState>();
//
//       final goalNameFormField=TextFormField(
//       controller: TextEditingController(text: goalName),
//       decoration: InputDecoration(hintText: 'Goal Name'),
//       validator: (value) => value!.isEmpty? 'Please enter a goal name': null,
//       );
//       final selectEndDateFormField = TextFormField(
//       controller: TextEditingController(text: selectEndDate),
//       decoration: InputDecoration(hintText: 'Select End Date'),
//       validator: (value) => value!.isEmpty? 'Please select an end date':null,
//       );
//
//       final formFields={
//         'goalName':goalNameFormField,
//       'selectEndDate':selectEndDateFormField,
//
//       };
//       formKey.currentState=FormStateMock(formFields);
//
//       //Act
//       await saveGoal.save(formKey);
//
//       //Assert
//       verify(mockFirestore.collection('users').where('email',isEqualTo: anyNamed('isEqualTo')));
//       verify(mockFirestore.collection('goals').add({
//         'goalName':goalName,
//       'startDate':anyNamed('startDate'),
//       'endDate':selectEndDate,
//       'completed':false,
//       'createdAt':anyNamed('createdAt'),
//       }));
//
//     });
//   });
// }
//
// class FormStateMock extends Mock implements FormState {}
//
// class QuerySnapshotMock extends Mock implements QuerySnapshot {}
//
// class DocumentReferenceMock extends Mock implements DocumentReference {}
