import 'package:data_app/controller/product_controller.dart';
import 'package:data_app/views/product/list/product_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pc = ref.read(productController);
    final pm = ref.watch(productListViewModel);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("product_list_page"),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) => ListTile(
          onTap: () {},
          leading: Icon(Icons.account_balance_wallet),
          title: Text(
            "${pm[index].name}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("${pm[index].price}"),
        ),
      ),
    );
  }
}
