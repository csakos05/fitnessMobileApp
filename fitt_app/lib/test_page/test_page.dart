import 'package:fitt_app/test_page/ex_repo.dart';
import 'package:fitt_app/test_page/example_hive_model.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final ProductRepository _exRepo = ProductRepository();
  Product? _product;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _createAndSaveProduct();
  }

  Future<void> _createAndSaveProduct() async {
    // Create a mock product with DateTime.now as ID
    final productId = DateTime.now().millisecondsSinceEpoch % 100000; // Unique ID based on current time
    final mockProduct = Product(
      id: productId,
      title: "Test Product",
      price: 29.99,
      category: Categories.beauty,
      stock: 10,
    );

    // Save to Hive
    await _exRepo.saveProduct(mockProduct);

    // Load the product to display
    final product = await _exRepo.getProductById(productId);

    setState(() {
      _product = product;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Test'),
      ),
      body: Center(
        child: _isLoading
          ? const CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Product Details:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Text('ID: ${_product?.id}'),
                Text('Title: ${_product?.title}'),
                Text('Price: \$${_product?.price}'),
                Text('Category: ${_product?.category.name}'),
                Text('Stock: ${_product?.stock}'),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    await _exRepo.clearAll();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Clear Hive & Go Back'),
                ),
              ],
            ),
      ),
    );
  }
}