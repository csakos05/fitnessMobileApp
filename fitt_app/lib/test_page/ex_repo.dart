import 'package:fitt_app/storage/hive_boxes.dart';
import '../storage/abstract_hive_repository.dart';
import 'example_hive_model.dart';

class ProductRepository extends HiveRepository<Product> {

  ProductRepository() : super(hiveBoxName: HiveBoxNames.productsBox);

  Future<Product?> getProductById(int id) async {
    return await getValue(id);
  }

  Future<void> saveProduct(Product product) async {
    await putValue(product.id, product);
  }

  Future<List<Product>> getAllProducts() async {
    return await getAllValues();
  }

  Future<List<Product>> getProductsByCategory(Categories category) async {
    final allProducts = await getAllProducts();
    return allProducts.where((product) => product.category == category).toList();
  }

  Future<void> updateProductStock(int productId, int newStock) async {
    final product = await getProductById(productId);
    if (product != null) {
      product.stock = newStock;
      await saveProduct(product);
    }
  }
}