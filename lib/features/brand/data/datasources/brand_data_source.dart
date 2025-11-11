import '../models/brand_model.dart';

abstract class BrandDataSource {
  Future<List<BrandModel>> getAllBrands();
  Future<BrandModel?> getBrandById(String id);
}

class BrandDataSourceImpl implements BrandDataSource {
  // Mock data for demonstration
  final List<BrandModel> _mockBrands = [
    BrandModel(id: '1', name: 'Lipsy London'),
    BrandModel(id: '2', name: 'Pronovias'),
    BrandModel(id: '3', name: 'Women Secret'),
    BrandModel(id: '4', name: 'Springfield'),
    BrandModel(id: '5', name: 'Cortefiel'),
  ];

  @override
  Future<List<BrandModel>> getAllBrands() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockBrands;
  }

  @override
  Future<BrandModel?> getBrandById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _mockBrands.firstWhere((brand) => brand.id == id);
    } catch (e) {
      return null;
    }
  }
}

