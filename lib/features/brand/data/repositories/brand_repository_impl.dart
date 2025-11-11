import '../../domain/entities/brand.dart';
import '../../domain/repositories/brand_repository.dart';
import '../datasources/brand_data_source.dart';

class BrandRepositoryImpl implements BrandRepository {
  final BrandDataSource dataSource;

  BrandRepositoryImpl({required this.dataSource});

  @override
  Future<List<Brand>> getAllBrands() async {
    return await dataSource.getAllBrands();
  }

  @override
  Future<Brand?> getBrandById(String id) async {
    return await dataSource.getBrandById(id);
  }
}

