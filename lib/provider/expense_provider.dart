import 'package:flutter/material.dart';
import 'package:flutter_expense_app/models/expense_model.dart';

class ExpenseProvider extends ChangeNotifier {
  late Map<DateTime, List<ExpenseModel>>? mySelectDate = {DateTime.now(): []};
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

// ExpenseProvider.listOfDayEvents();

  List<ExpenseModel> listOfDayEvents(DateTime dateTime) {
    return mySelectDate![dateTime] ?? [];
  }

  double getExpense(DateTime dateTime) {
    var data = mySelectDate![dateTime];
    var money = 0.0;
    if (data != null) {
      data.forEach((element) {
        money = money + element.prices!;
      });
      return money;
    }
    return money;
  }

  String? getName(DateTime dateTime) {
    var data = mySelectDate![dateTime];
    var money = 0.0;
    if (data != null) {
      data.forEach((element) {
        money = money + element.prices!;
      });
      return money.toString();
    }
    return null;
  }

}
