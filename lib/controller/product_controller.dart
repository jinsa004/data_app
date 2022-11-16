// VIEW -> Controller
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:data_app/views/product/list/product_list_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 창고에 컨트롤러가 등록됨!!! 스프링의 @Component 같은 기능
final productController = Provider<ProductController>((ref) {
  return ProductController(ref);
});

class ProductController {
  final Ref _ref;
  ProductController(this._ref);

  void findAll() {
    // 외부통신으로 findAll 데이터를 받음
    List<Product> productList = _ref.read(productHttpRepository).findAll();
    // 들고온 findAll 데이터를 VM에 던지고 view는 watch로 값을 받아서 rebuild 되는 것
    _ref.read(productListViewModel.notifier).onRefresh(productList);
  }
}
