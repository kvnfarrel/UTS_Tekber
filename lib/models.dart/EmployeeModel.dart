class EmployeeModel {
  final String name;
  final String address;

  EmployeeModel({required this.name, required this.address});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      name: map['name'],
      address: map['address'],
    );
  }
}