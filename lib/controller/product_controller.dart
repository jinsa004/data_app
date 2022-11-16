// VIEW -> Controller
import 'dart:convert';

import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:data_app/main.dart';
import 'package:data_app/views/components/my_alert_dialog.dart';
import 'package:data_app/views/product/list/product_list_view_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 창고에 컨트롤러가 등록됨!!! 스프링의 @Component 같은 기능
final productController = Provider<ProductController>((ref) {
  return ProductController(ref);
});

/**
 * 컨트롤러 : 비즈니스 로직 담당 (화면전환 등)
 */
class ProductController {
  final context = navigatorKey.currentContext!;
  final Ref _ref;
  ProductController(this._ref);

  void findAll() {
    // 외부통신으로 findAll 데이터를 받음
    List<Product> productList = _ref.read(productHttpRepository).findAll();
    // 들고온 findAll 데이터를 VM에 던지고 view는 watch로 값을 받아서 rebuild 되는 것
    _ref.read(productListViewStore.notifier).onRefresh(productList);
  }

  void insert(Product productReqDto) {
    // Repository에 insert 요청
    Product productRespDto =
        _ref.read(productHttpRepository).insert(productReqDto);
    // 응답받은 값을 VS가 받아서 갱신
    _ref.read(productListViewStore.notifier).nfAddProduct(productRespDto);
  }

  void deleteById(int id) {
    int result = _ref.read(productHttpRepository).deleteById(id);
    if (result == 1) {
      _ref.read(productListViewStore.notifier).removeProduct(id);
      showCupertinoDialog(
          context: context, builder: (context) => MyAlertDialog(msg: "삭제성공"));
    } else {
      showCupertinoDialog(
          context: context, builder: (context) => MyAlertDialog(msg: "삭제실패"));
    }
  }

  void updateById(Product product) {
    Product productPS = _ref.read(productHttpRepository).findById(product.id);
    productPS.price = product.price;
    Product productRespDto =
        _ref.read(productHttpRepository).updateById(product.id, productPS);
    _ref.read(productListViewStore.notifier).updateProduct(productRespDto);
  }
}
