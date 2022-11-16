import 'package:data_app/controller/product_controller.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/views/components/my_alert_dialog.dart';
import 'package:data_app/views/product/list/product_list_view_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListView extends ConsumerWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pc = ref.read(productController);
    final pm = ref.watch(productListViewStore);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pc.insert(Product(4, '호박', 2000));
          showCupertinoDialog(
            context: context,
            builder: (context) => MyAlertDialog(msg: "추가성공"),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("product_list_page"),
      ),
      body: ListView.builder(
        itemCount: pm.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            pc.deleteById(pm[index].id, context);
          },
          leading: Icon(Icons.account_balance_wallet),
          title: Text(
            "${pm[index].name}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("${pm[index].price}"),
          onLongPress: () {
            pc.updateById(pm[index].id);
          },
        ),
      ),
    );
  }
}
