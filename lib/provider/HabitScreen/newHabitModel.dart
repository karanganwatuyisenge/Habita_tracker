import 'package:flutter/cupertino.dart';

class HabitModel extends ChangeNotifier{
String habitName='';
String habitType='';
int habitFrequency =0;
int _habitCount=0;

int  get habitCount => _habitCount;

void updateHabitCount(int count){
  _habitCount=count;
  notifyListeners();
}

void setHabitName(String name){
  habitName=name;
  notifyListeners();
}

void setHabitType(String type){
  habitType=type;
  notifyListeners();
}

int setHabitFrequency(int frequency){
  habitFrequency=frequency;
  notifyListeners();
  return frequency;
}

}



