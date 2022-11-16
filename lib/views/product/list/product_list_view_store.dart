import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListViewStore =
    StateNotifierProvider<ProductListViewStore, List<Product>>((ref) {
  return ProductListViewStore(ref.read(productHttpRepository).findAll());
});

class ProductListViewStore extends StateNotifier<List<Product>> {
  ProductListViewStore(super.state);

  void onRefresh(List<Product> products) {
    state = products;
  }

  void nfAddProduct(Product productRespDto) {
    state = [...state, productRespDto];
  }
}
