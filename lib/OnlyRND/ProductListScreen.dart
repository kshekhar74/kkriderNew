import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Product.dart';
import 'ProductService.dart';

final productsProvider = FutureProvider<List<Product>>((ref) async {
  return ProductService.fetchProducts("maybelline");
});

final selectedProductIndexProvider = StateProvider<int>((ref) => -1);

class ProductListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);
    final selectedIndex = ref.watch(selectedProductIndexProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maybelline Products'),
        backgroundColor: Colors.pinkAccent,
        elevation: 4,
      ),
      body: Container(
        color: Colors.grey[100],
        child: productsAsync.when(
          data: (products) => ListView.separated(
            itemCount: products.length,
            padding: const EdgeInsets.all(12),
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final product = products[index];
              final isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  ref.read(selectedProductIndexProvider.notifier).state = index;
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected
                            ? Colors.greenAccent.withOpacity(0.3)
                            : Colors.black12,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: isSelected
                        ? Border.all(color: Colors.greenAccent, width: 2)
                        : null,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.imageLink,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: Icon(
                      isSelected ? Icons.check_circle : Icons.radio_button_off,
                      color: isSelected ? Colors.green : Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}
