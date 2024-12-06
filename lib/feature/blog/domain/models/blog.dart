class Blog {
  final String id;
  final String title;
  final String content;
  final String posterName;
  final String? imageUrl;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.posterName,
    this.imageUrl,
  });

  Blog copyWith({
    String? id,
    String? title,
    String? content,
    String? posterName,
    String? imageUrl,
  }) {
    return Blog(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      posterName: posterName ?? this.posterName,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'posterName': posterName,
      'imageUrl': imageUrl,
    };
  }

  factory Blog.fromJson(Map<String, dynamic> map) {
    return Blog(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      posterName: map['posterName'] ?? '',
      imageUrl: map['imageUrl'],
    );
  }
} 