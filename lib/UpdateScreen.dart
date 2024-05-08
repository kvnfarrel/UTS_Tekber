import 'package:flutter/material.dart';
import 'package:uts_tekber/EmployeePage.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String? _name ;
  // ignore: unused_field
  String? _address ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data Pekerja', style: TextStyle(color: Colors.white),),
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
              onSaved: (value) => _name = value?? '' ,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Alamat'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Tolong Tulis Alamat';
                }
                return null;
                },
              onSaved: (value) => _address = value?? '',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Simpan'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.pop(context, EmployeePage());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}