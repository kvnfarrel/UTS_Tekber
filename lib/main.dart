import 'package:flutter/material.dart';
import 'package:uts_tekber/EmployeePage.dart';
import 'package:provider/provider.dart';
import 'package:uts_tekber/EmployeeProvider.dart';

// import 'EmployeeProvider.dart';
// import 'EmployeePage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmployeeProvider(),
      child: MaterialApp(
        title: 'MyApp',
        home: EmployeePage(),
      ),
    );
  }
}