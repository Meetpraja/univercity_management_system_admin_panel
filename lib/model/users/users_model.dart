class UsersModel {
  final String? id;
  final String? email;
  final String? name;
  final String? enrollment_no;
  final String? role;
  final String? departmentName;
  final String? contact;
  final String? className;

  UsersModel({
    this.id,
    this.email,
    this.name,
    this.enrollment_no,
    this.role,
    this.departmentName,
    this.contact,
    this.className,
  });

  // Factory method to create a User object from a JSON map
  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      id: map['id'] as String,
      email: map['email'] ?? '',
      name: map['name']  ?? '',
      enrollment_no: map['enrollment_no'] ?? '',
      role: map['role']  ?? '',
      departmentName: map['department_name'] ?? '',
      contact: map['contact'] ?? '',
      className: map['class_name'] ?? '',
    );
  }

  // Method to convert a User object to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'id' : id!,
      'email': email!,
      'name': name!,
      'enrollment_no' : enrollment_no!,
      'role': role!,
      'department_name': departmentName!,
      'contact': contact!,
      'class_name': className,
    };
  }

}
