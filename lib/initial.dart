import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/expense_provider.dart';
import 'ui/my_app.dart';

class MyAppLanch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ExpenseProvider()),
      ],
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: MaterialApp(
          title: 'Expense App',
          home: MyApp(),
        ),
      ),
    );
  }
}
