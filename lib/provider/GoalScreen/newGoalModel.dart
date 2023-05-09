import 'package:flutter/cupertino.dart';

class GoalModel extends ChangeNotifier {
  String goalName = '';
  String startDate = '';
  String endDate = '';


  void setGoalName(String name) {
    goalName = name;
    notifyListeners();
  }

  void setStartDate(String date) {
    startDate = date;
    notifyListeners();
  }

  void setEndDate(String date) {
    endDate = date;
    notifyListeners();
  }
}