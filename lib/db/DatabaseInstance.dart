import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uts_tekber/models.dart/EmployeeModel.dart';

class DatabaseInstance {
  late Database _database;

  // Membuka atau membuat database jika belum ada
  Future<void> database() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'employee_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE employees( name TEXT PRIMARY KEY, address TEXT)',
        );
      },
      version: 1,
    );
  }

  // Mengambil semua data pegawai dari database
  Future<List<Employee>> getAll() async {
    final List<Map<String, dynamic>> employeeMaps = await _database.query('employees');

    // Mengonversi List<Map<String, dynamic>> menjadi List<Employee>
    return List.generate(employeeMaps.length, (i) {
      return Employee(

        name: employeeMaps[i]['name'],
        address: employeeMaps[i]['address'],
      );
    });
  }

  // Menambahkan pegawai baru ke dalam database
  Future<void> insertEmployee(EmployeeModel employee) async {
    await _database.insert(
      'employees',
      employee.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

class Employee {

  final String name;
  final String address;

  Employee({required this.name, required this.address});

  // Konversi objek Employee menjadi Map
  Map<String, dynamic> toMap() {
    return {

      'name': name,
      'address': address,
    };
  }
}

void main() async {
  // Membuat instance dari DatabaseInstance
  DatabaseInstance databaseInstance = DatabaseInstance();
  
  // Membuka atau membuat database
  await databaseInstance.database();

  // Untuk menambahkan data:
  Employee newEmployee = Employee( name: 'kevin', address: 'semarang');
  await databaseInstance.insertEmployee(newEmployee as EmployeeModel);

  // Untuk mengambil semua data:
  // ignore: unused_local_variable
  List<Employee> employees = await databaseInstance.getAll();

// Menampilkan data karyawan
  // ignore: use_function_type_syntax_for_parameters
  employees.forEach((employee) {
    print('Name: ${employee.name}, Address: ${employee.address}');
  });
}