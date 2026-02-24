class TaskModel {
  final String id;
  final String title;
  final bool isCompleted;
  final String? category;
  final String? color;
  final String? date;
  final bool? isDeleted;
  final bool? remind;
  final bool? repeat;
  final String? notes;
  final String? image;
  final String? priority;
  String? deletedDate = DateTime(3099).toIso8601String();
  String? createdAt = DateTime.now().toIso8601String();

  TaskModel({
    required this.id,
    required this.title,
    required this.isCompleted,
    this.date,
    this.remind,
    this.repeat,
    this.notes,
    this.image,
    this.priority,
    this.category,
    this.color,
    this.isDeleted,
    this.deletedDate,
  });

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'category': category ?? "general",
      'color': color ?? "blue",
      'date': date ?? "",
      'deletedDate': deletedDate ?? '',
      'remind': remind ?? false,
      'repeat': repeat ?? false,
      'notes': notes ?? '',
      'image': image ?? '',
      'priority': priority ?? 'normal',
      'isDeleted': isDeleted ?? false,
    };
  }

  factory TaskModel.fromjson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool,
      category: json['category'] as String?,
      color: json['color'] as String?,
      date: json['date'] as String?,
      deletedDate: json["deletedDate"] as String?,
      remind: json['remind'] as bool?,
      repeat: json['repeat'] as bool?,
      notes: json['notes'] as String?,
      image: json['image'] as String?,
      priority: json['priority'] as String?,
      isDeleted: json['isDeleted'] as bool?,
    );
  }
  TaskModel copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    String? category,
    String? color,
    String? date,
    bool? isDeleted,
    bool? remind,
    bool? repeat,
    String? notes,
    String? image,
    String? priority,
    String? deletedDate,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category ?? this.category,
      color: color ?? this.color,
      date: date ?? this.date,
      isDeleted: isDeleted ?? this.isDeleted,
      remind: remind ?? this.remind,
      repeat: repeat ?? this.repeat,
      notes: notes ?? this.notes,
      image: image ?? this.image,
      priority: priority ?? this.priority,
      deletedDate: deletedDate ?? this.deletedDate,
    );
  }

  Map<String, dynamic> tojsonWithTime() {
    return {
      'id': id,
      'title': title,
      'category': category ?? "general",
      'color': color ?? "blue",
      'isCompleted': isCompleted,
      'date': DateTime.parse(date!),
      'remind': remind ?? false,
      'repeat': repeat ?? false,
      'notes': notes ?? '',
      'image': image ?? '',
      'priority': priority ?? 'normal',
      "isDeleted": isDeleted ?? false,
      "deletedDate": deletedDate ?? '',
    };
  }
}
