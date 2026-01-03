import 'package:dz_pub/api/promations_models/promotions.dart';
import 'package:dz_pub/constants/strings.dart';

class Advertisement {
  final int? id;
  final int? promotionId;
  final String? description;
  final String? filePath;
  final String? createdAt;
  final String? updatedAt;
  final Promotion? promotion;

  Advertisement({
    this.id,
    this.promotionId,
    this.description,
    this.filePath,
    this.createdAt,
    this.updatedAt,
    this.promotion,
  });

  bool get isImage {
    if (filePath == null) return false;
    final path = filePath!.toLowerCase();
    return path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.png') ||
        path.endsWith('.gif') ||
        path.endsWith('.webp');
  }

  bool get isVideo {
    if (filePath == null) return false;
    final path = filePath!.toLowerCase();
    return path.endsWith('.mp4') ||
        path.endsWith('.mov') ||
        path.endsWith('.avi') ||
        path.endsWith('.mkv');
  }

  String? get fullImageUrl {
    if (filePath == null) return null;
    if (filePath!.startsWith('http')) return filePath;
    return '${ServerLocalhostEm.storagePath}$filePath';
  }

  factory Advertisement.fromJson(Map<String, dynamic> json) {
    return Advertisement(
      id: json['id'],
      promotionId: json['promation_id'],
      description: json['description'],
      filePath: json['file_path'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      promotion: json['promation'] != null
          ? Promotion.fromJson(json['promation'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'promation_id': promotionId,
      'description': description,
      'file_path': filePath,
      'created_at': createdAt,
      'updated_at': updatedAt,
      // Leaving out promotion.toJson for now as it's not strictly needed for this task
    };
  }
}
