import 'package:flutter/material.dart';
import 'package:flutter_expense_app/models/expense_model.dart';
import 'package:flutter_expense_app/provider/expense_provider.dart';
import 'package:flutter_expense_app/utils/icon_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'components/bzbs_custom_show_dialog.dart';
import 'components/dialog.dart';
import 'components/popup.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime? _focusedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  ExpenseProvider _expenseProvider = ExpenseProvider();
  List<ExpenseModel> _selectedEvents = [];
  Map<DateTime, List<ExpenseModel>> mySelectDate = {};

  TextEditingController expenceController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  int dropdownValue = 0;

  @override
  Widget build(BuildContext context) {
//เรียกใช้ provider
    ExpenseProvider expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.date_range),
        ),
        title: Text(expenseProvider.getName(_selectedDay!) != null
            ? "${expenseProvider.getName(_selectedDay!)} EUR"
            : 'MY Expensed'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
          onPressed: () {
            customShowDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return PopupEnterExpense(
                    expenceController: expenceController,
                    priceController: priceController,
                    // dropdownValue: dropdownValue,
                    onSelectIcon: (v) {
                      print(v);
                      setState(() {
                        dropdownValue = v;
                      });
                    },
                    onPressed: () {
                      // onSelectDay(_selectedDay, _focusedDay);
                      setState(() {
                        if (expenseProvider.mySelectDate![_selectedDay] !=
                            null) {
                          expenseProvider.mySelectDate![_selectedDay]?.add(
                              ExpenseModel(
                                  title: expenceController.text,
                                  prices: double.parse(priceController.text),
                                  icon: ListIcon().icon[dropdownValue]));
                        } else {
                          expenseProvider.mySelectDate![_selectedDay!] = [
                            ExpenseModel(
                                title: expenceController.text,
                                prices: double.parse(priceController.text),
                                icon: ListIcon().icon[dropdownValue])
                          ];
                        }
                      });
                      print('adddddd');
                      Navigator.pop(context);
                    });
              },
            );
          }),
      body: Column(
        children: [
          Container(
            child: TableCalendar(
              eventLoader: expenseProvider.listOfDayEvents,
              headerVisible: true,
              headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, local) {
                    return DateFormat.MMM(local).format(date);
                  }),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _selectedDay!,
              // currentDay: _selectedDay,
              calendarFormat: _calendarFormat,
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  if (events.isNotEmpty) {
                    var data = expenseProvider.getExpense(day);
                    return Positioned(
                      bottom: 1,
                      child: Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Text('$data')),
                    );
                  } else {}
                },
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              rowHeight: 100,
              onDaySelected: onSelectDay,
              onPageChanged: (focusedDay) {
                print(focusedDay);
                _focusedDay = focusedDay;
              },
              calendarStyle: CalendarStyle(
                // Weekend dates color (Sat & Sun Column)
                weekendTextStyle: TextStyle(color: Colors.red),
                // highlighted color for today
                todayDecoration: BoxDecoration(
                  color: Colors.black12,
                  shape: BoxShape.circle,
                ),
                markerDecoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                todayTextStyle: TextStyle(color: Colors.black),
                selectedDecoration:
                    BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount:
                      expenseProvider.mySelectDate![_selectedDay]?.length ==
                              null
                          ? 0
                          : expenseProvider.mySelectDate![_selectedDay]?.length,
                  itemBuilder: (context, int index) {
                    var item =
                        expenseProvider.mySelectDate![_selectedDay]?[index];
                    return ListTile(
                      leading: item!.icon,
                      title: Text("${item.title}"),
                      trailing: Text(item.prices.toString()),
                      tileColor:
                          index % 2 == 0 ? Colors.lightBlue[50] : Colors.white,
                    );
                  })),
        ],
      ),
    );
  }

  void onSelectDay(selectedDay, focusedDay) {
    // if (!isSameDay(_selectedDay, selectedDay)) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _selectedDay = _focusedDay;
    });
  }
}

