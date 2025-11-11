import '../entities/brand.dart';

abstract class BrandRepository {
  Future<List<Brand>> getAllBrands();
  Future<Brand?> getBrandById(String id);
}

