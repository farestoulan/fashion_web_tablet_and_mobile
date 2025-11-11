import '../entities/brand.dart';
import '../repositories/brand_repository.dart';

class GetAllBrands {
  final BrandRepository repository;

  GetAllBrands(this.repository);

  Future<List<Brand>> call() async {
    return await repository.getAllBrands();
  }
}

