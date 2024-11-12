class Note {
  final int? id;
  final String title;
  final String content;
  final int categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.categoryId,
    this.createdAt,
    this.updatedAt,
  });
}
