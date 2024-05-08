import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:uts_tekber/EmployeeAddPage.dart';
import 'package:uts_tekber/UpdateScreen.dart';
import 'package:uts_tekber/EmployeeProvider.dart';
import 'package:provider/provider.dart';

class Employee {
  final String name;
  final String address;

  Employee({required this.name, required this.address});
}

class EmployeePage extends StatefulWidget {
  @override
  _EmployeePageState createState() => _EmployeePageState();
  
}

class _EmployeePageState extends State<EmployeePage> {
DatabaseInstance? databaseInstance;
@override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  Future initDatabase() async{
    await databaseInstance!.database();
    setState(() {
      
    });
  }
  // Fungsi untuk menavigasi ke halaman update
  void _goToUpdateScreen(Employee ) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateScreen()), // Ganti dengan halaman update yang sesuai
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pekerja', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<EmployeeProvider>(
        builder: (context, employeeProvider, child) {
          final List<Employee> employees = employeeProvider.employees.cast<Employee>();
          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final Employee employee = employees[index];
              return ListTile(
                title: Text(employee.name),
                subtitle: Text(employee.address),
                  leading: Icon(Icons.person),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _goToUpdateScreen(employee),
                        icon: Icon(Icons.edit, color: Colors.grey),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Konfirmasi'),
                                content: Text('Apakah Anda yakin ingin menghapus data ini?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Tambahkan logika penghapusan di sini
                                      Navigator.pop(context);
                                    },
                                    child: Text('Hapus'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmployeeAddPage()),
          );
        },
      ),
    );
  }
}

EmployeeModel({required ListTile Function(dynamic context) builder}) {
}

class DatabaseInstance {
  database() {}
  
  getAll() {}

  insertEmployee(Employee newEmployee) {}
}
