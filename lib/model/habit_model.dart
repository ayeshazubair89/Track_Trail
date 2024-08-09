class Habit {
  String id;
  String title;
  String repeatFrequency;
  Map<String, bool> completionDates;

  Habit({
    required this.id,
    required this.title,
    required this.repeatFrequency,
    required this.completionDates,
  });

  // Convert a Habit object into a map object for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'repeatFrequency': repeatFrequency,
      'completionDates': completionDates,
    };
  }

  // Create a Habit object from a map object
  factory Habit.fromMap(String id, Map<String, dynamic> data) {
    return Habit(
      id: id,
      title: data['title'],
      repeatFrequency: data['repeatFrequency'],
      completionDates: Map<String, bool>.from(data['completionDates'] ?? {}),
    );
  }
}
