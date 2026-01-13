class Task {
  String id;
  String title;
  String description;
  String status;
  String dueDate;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.dueDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'status': status,
      'dueDate': dueDate,
    };
  }
}
