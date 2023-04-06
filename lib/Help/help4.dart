// import 'package:flutter/material.dart';
//
// class Help4 extends StatefulWidget {
//   const Help4({Key? key}) : super(key: key);
//
//   @override
//   State<Help4> createState() => _Help4State();
// }
//
// class _Help4State extends State<Help4> {
//   Map<String, Map<String, dynamic>> myMap = {
//     'January2023': {
//       'count': 5,
//       'dates': ['2023-01-02', '2023-01-04', '2023-01-07', '2023-01-09', '2023-01-11']
//     },
//     'February2023': {
//       'count': 3,
//       'dates': ['2023-02-02', '2023-02-04', '2023-02-07','2023-04-05']
//     },
//     'March2023': {
//       'count': 7,
//       'dates': ['2023-03-01', '2023-03-05', '2023-03-07', '2023-03-10', '2023-03-14', '2023-03-17', '2023-03-20']
//     }
//   };
//   Hashmap have another map insidewhich have the name of month,year we are in(which has one field called count that has a datatype of number and other field called dates have a datatype of an array and that array holds a string ) in flutter help me to implement it and how can i access dates field where dates is not equal to current dates
//   void printValidDates() {
//     String currentDate = DateTime.now().toString().substring(0, 10);
//     myMap.forEach((monthYear, monthData) {
//       List<String> validDates = [];
//       monthData['dates'].forEach((date) {
//         if (date != currentDate) {
//           validDates.add(date);
//         }
//       });
//       print('Month-Year: $monthYear');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     printValidDates();
//     return const Placeholder();
//   }
// }
