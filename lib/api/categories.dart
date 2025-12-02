class CategoryResponse {
  final String ?message;
  final List<Category>? categories;

  CategoryResponse({ this.message,  this.categories});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      message: json['message'],
      categories: (json['categories'] as List)
          .map((cat) => Category.fromJson(cat))
          .toList(),
    );
  }
}

class Category {
  final int? id;
  final String ?name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category({
     this.id,
     this.name,
     this.createdAt,
     this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
extension CategoryJson on Category {
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
