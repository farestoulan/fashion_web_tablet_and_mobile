import '../../domain/entities/brand.dart';

class BrandModel extends Brand {
  BrandModel({
    required super.id,
    required super.name,
    super.logoUrl,
    super.description,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] as String,
      name: json['name'] as String,
      logoUrl: json['logoUrl'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logoUrl': logoUrl,
      'description': description,
    };
  }
}

