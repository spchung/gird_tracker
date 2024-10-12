class WorkoutGroup {
  String name;
  int? id;
  String? description;

  WorkoutGroup({
    required this.name, 
    this.description,
    this.id
  });

  factory WorkoutGroup.fromMap(Map<String, dynamic> map) {
    return WorkoutGroup(
      id: map['id'],
      name: map['name'],
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description ?? '',
    };
  }
}