// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import 'package:uts_tekber/EmployeePage.dart' as EmployeePage;
import 'package:uts_tekber/db/DatabaseInstance.dart'; // Impor kelas DatabaseInstance
import 'package:uts_tekber/EmployeeProvider.dart' as provider;
import 'package:uts_tekber/models.dart/EmployeeModel.dart'; // Import EmployeeModel

class EmployeeAddPage extends StatefulWidget {
  @override
  _EmployeeAddPageState createState() => _EmployeeAddPageState();
}

class _EmployeeAddPageState extends State<EmployeeAddPage> {


  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _address;

  // Instance dari kelas DatabaseInstance
  final DatabaseInstance _databaseInstance = DatabaseInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Data Pekerja', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Nama'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Tolong Tulis Nama';
                }
                return null;
              },
              onSaved: (value) => _name = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Alamat'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Tolong Tulis Alamat';
                }
                return null;
              },
              onSaved: (value) => _address = value,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Simpan'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Simpan data ke dalam database
                  _saveDataToDatabase();
                  // Pindah ke halaman EmployeePage dan secara otomatis perbarui tampilannya
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeePage.EmployeePage(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menyimpan data ke dalam database
  void _saveDataToDatabase() async {
    // Buat objek EmployeeModel dari data yang dimasukkan
    EmployeeModel newEmployee = EmployeeModel(
      name: _name!,
      address: _address!,
    );

    // Panggil metode untuk menyisipkan data baru ke dalam database
    await _databaseInstance.insertEmployee(newEmployee);
  }
}