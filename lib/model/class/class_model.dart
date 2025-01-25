class ClassModel {
  final String? id;
  final String? name;
  final String? department_name;

  ClassModel({
    this.id,
    this.name,
    this.department_name
  });

  // Factory method to create a User object from a JSON map
  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id: map['id'] as String,
      name: map['name']  ?? '',
      department_name: map['department_name'] ?? ''
    );
  }

  // Method to convert a User object to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'id' : id!,
      'name': name!,
      'department_name' : department_name!
    };
  }
}