class Brand {
  final String id;
  final String name;
  final String? logoUrl;
  final String? description;

  Brand({
    required this.id,
    required this.name,
    this.logoUrl,
    this.description,
  });
}

