class DepartmentsModel {
  final String? id;
  final String? name;

  DepartmentsModel({
    this.id,
    this.name,
  });

  // Factory method to create a User object from a JSON map
  factory DepartmentsModel.fromMap(Map<String, dynamic> map) {
    return DepartmentsModel(
      id: map['id'] as String,
      name: map['name']  ?? '',
    );
  }

  // Method to convert a User object to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'id' : id!,
      'name': name!,
    };
  }
}
