class TaskModel {
  final String id;
  final String title;
  final String? category;
  final String? color;
  final bool isCompleted;
  final String? date;
  final String? time;
  final bool? remind;
  final bool? repeat;
  final String? notes;
  final String? image;
  final String? priority;

  TaskModel({
    required this.id,
    this.date,
    this.time,
    this.remind,
    this.repeat,
    this.notes,
    this.image,
    this.priority,
    required this.title,
    this.category,
    this.color,
    required this.isCompleted,
  });

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'title': title,
      'category': category ?? "general",
      'color': color ?? "blue",
      'isCompleted': isCompleted,
      'date': date ?? "",
      'time': time ?? "",
      'remind': remind ?? false,
      'repeat': repeat ?? false,
      'notes': notes ?? '',
      'image': image ?? '',
      'priority': priority ?? 'normal',
    };
  }

  factory TaskModel.fromjson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String?,
      color: json['color'] as String?,
      isCompleted: json['isCompleted'] as bool,
      date: json['date'] as String?,
      time: json['time'] as String?,
      remind: json['remind'] as bool?,
      repeat: json['repeat'] as bool?,
      notes: json['notes'] as String?,
      image: json['image'] as String?,
      priority: json['priority'] as String?,
    );
  }
  TaskModel copyWith({
    String? id,
    String? title,
    String? category,
    String? color,
    bool? isCompleted,
    String? date,
    String? time,
    bool? remind,
    bool? repeat,
    String? notes,
    String? image,
    String? priority,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      color: color ?? this.color,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
      time: time ?? this.time,
      remind: remind ?? this.remind,
      repeat: repeat ?? this.repeat,
      notes: notes ?? this.notes,
      image: image ?? this.image,
      priority: priority ?? this.priority,
    );
  }
}
