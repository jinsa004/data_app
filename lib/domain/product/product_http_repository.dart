import 'package:data_app/domain/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productHttpRepository = Provider<ProductHttpRepository>((ref) {
  return ProductHttpRepository();
});

// 밑에서 사용되는 모든 Product는 실전에서는 DTO화할 것!
class ProductHttpRepository {
  // fake data
  List<Product> list = [
    Product(1, "바나나", 1000),
    Product(2, "딸기", 2000),
    Product(3, "수박", 3000)
  ];

  Product findById(int id) {
    // http 통신 코드
    // 통신은 보통 리턴 값 앞에 Future<Entity>로 감싸서 리턴해줌. 옵셔널 박스처럼 퓨처 박스를 먼저 리턴해줌.
    // Future 박스 안의 값이 null이다가 통신이 완료되어 값이 들어오면 Provider watch가 캐치해서 들고 감.
    Product product = list.singleWhere((product) => product.id == id);
    return product;
  }

  List<Product> findAll() {
    // http 통신 코드
    return list;
  }

  // name, price
  Product insert(Product product) {
    // http 통신 코드(product 전송)
    product.id = 4; //통신이 끝났을 때 응답받은 id 값을 임의로 부여해줌(연습이니까)
    list = [...list, product];
    return product;
  }

  Product updateById(int id, Product productDto) {
    // http 통신 코드
    list = list.map((product) {
      if (product.id == id) {
        product = productDto;
        return productDto;
      } else {
        return product;
      }
    }).toList();
    // 업데이트 본 코드일 것 위의 코드는 아직 서버 연결이 안되서 임의로 만든 것.
    productDto.id = id;
    return productDto;
  }

  int deleteById(int id) {
    // http 통신 코드
    list = list.where((product) => product.id != id).toList();
    return 1;
  }
}
