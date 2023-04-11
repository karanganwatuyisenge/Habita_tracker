import 'package:cloud_firestore/cloud_firestore.dart';

class CreateNewHabit {
  String habitName;
  Timestamp createdAt;
  int habitFrequent;
  int other;
  String habitType;
  Complete completed;

  CreateNewHabit({
    required this.habitFrequent,
    required this.createdAt,
    required this.other,
    required this.habitName,
    required this.habitType,
    required this.completed,
  });

  factory CreateNewHabit.fromJsonDocument(DocumentSnapshot json) =>
      CreateNewHabit(
          habitFrequent: json["habitFrequent"],
          createdAt: json["createdAt"],
          other: json["other"],
          habitName: json["habitName"],
          habitType: json["habitType"],
          completed: (json["completed"]));
}

// class Complete {
//   Map<String, dynamic> habitPeriod;
//
//   Complete({required this.habitPeriod});
//
//   factory Complete.fromMap(Map<String, dynamic> jsonMap) =>
//       Complete(habitPeriod: jsonMap[jsonMap]);
// }
class Complete {
  Map<String, dynamic> habitPeriod;

  Complete({required this.habitPeriod});

  factory Complete.fromMap(Map<String, dynamic> jsonMap) {
    Map<String, dynamic> habitPeriod = {};
    jsonMap['habitPeriod'].forEach((key, value) {
      habitPeriod[key] = {
        'count': value['count'],
        'dates': List<String>.from(value['dates'])
      };
    });
    return Complete(habitPeriod: habitPeriod);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> habitPeriod = {};
    this.habitPeriod.forEach((key, value) {
      habitPeriod[key] = {'count': value['count'], 'dates': value['dates']};
    });
    return {'habitPeriod': habitPeriod};
  }
}


