class Exercise {
  String name;
  String? description;
  int? id;
  int workoutGroupId;

  Exercise({
    required this.name,
    required this.workoutGroupId,
    this.description,
    this.id,
  });

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'],
      workoutGroupId: map['workout_group_id'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'workout_group_id': workoutGroupId,
      'description': description ?? '',
    };
  }
}