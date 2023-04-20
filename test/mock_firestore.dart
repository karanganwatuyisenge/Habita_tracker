// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mockito/mockito.dart';
//
// import 'saveGoal_test.dart';
//
// class MockFirestore extends Mock implements FirebaseFirestore {}
//
// class MockCollectionReference extends Mock implements CollectionReference {}
//
// class MockDocumentReference extends Mock implements DocumentReference {}
//
// class MockQuerySnapshot extends Mock implements QuerySnapshot {}
//
// class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot {}
//
// class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}
//
//
// // class MockQueryConstraint extends Mock implements QueryConstraint {}
//
// class MockDocumentChange extends Mock implements DocumentChange {}
//
// class MockSnapshotMetadata extends Mock implements SnapshotMetadata {}
//
// class MockWriteBatch extends Mock implements WriteBatch {}
//
// class MockQuery extends Query<Map<String, dynamic>> with Mock {
//   @override
//   Future<QuerySnapshot<Map<String, dynamic>>> get([GetOptions? options]) async {
//     return QuerySnapshotMock();
//   }
// }
//
//
//
//   @override
//   Query<Map<String, dynamic>> where(
//       field, {
//         isEqualTo,
//         isNotEqualTo,
//         isGreaterThan,
//         isGreaterThanOrEqualTo,
//         isLessThan,
//         isLessThanOrEqualTo,
//         arrayContains,
//         arrayContainsAny,
//         whereIn,
//         whereNotIn,
//         isNull,
//       }) {
//     return this;
//   }
//
// // Implement other methods as needed
// }
//
//
// class MockTransaction extends Mock implements Transaction {}
