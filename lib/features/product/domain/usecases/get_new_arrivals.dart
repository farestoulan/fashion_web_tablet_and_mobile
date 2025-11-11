import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetNewArrivals {
  final ProductRepository repository;

  GetNewArrivals(this.repository);

  Future<List<Product>> call() async {
    return await repository.getNewArrivals();
  }
}

