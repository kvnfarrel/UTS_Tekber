import 'package:flutter/material.dart';

class Employee {
  final String name;
  final String address;

  Employee({required this.name, required this.address});
}

class EmployeeProvider extends ChangeNotifier {
  List<Employee> _employees = [];

  List<Employee> get employees => _employees;

  void addEmployee(Employee employee) {
    _employees.add(employee);
    notifyListeners();
  }
}