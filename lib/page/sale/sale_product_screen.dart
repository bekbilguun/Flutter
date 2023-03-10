import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profile/model/customer_model.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/model/inner_model.dart';
import 'package:profile/model/sale_model.dart';
import 'package:profile/model/sale_product_model.dart';
import 'package:profile/page/sale/sales_screen.dart';
import 'package:profile/utils/app_logger.dart';
import 'package:profile/widget/sale_widget.dart';
import '../../themes.dart';
import '../../widget/button_widget.dart';

class SaleProductScreen extends StatefulWidget {
  final Sale? sale;
  final SaleProduct? saleProduct;
  final Customers? customer;

  const SaleProductScreen(
      {Key? key, this.customer, this.sale, this.saleProduct})
      : super(key: key);

  @override
  State<SaleProductScreen> createState() => _SaleProductScreenState();
}

class _SaleProductScreenState extends State<SaleProductScreen> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    if (widget.customer != null) {
      nameController.text = widget.customer!.name;
      phoneController.text = widget.customer!.phone;
    }

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Hi ',
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                  child: Text(
                    widget.customer!.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 15, top: 10),
                  child: Center(
                    child: Text(
                      '????????????????????????',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: FutureBuilder<List<Inner>?>(
                      future:
                          DatabaseHelper.innerPriceCustomer(widget.customer),
                      builder: (context, AsyncSnapshot<List<Inner>?> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else if (snapshot.hasData) {
                          if (snapshot.data != null) {
                            return SaleProductsListView(
                              products: snapshot.data!,
                              sale: widget.sale,
                              customer: widget.customer,
                            );
                          }
                          return const Center(
                            child: Text('No notes yet'),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SaleProductsListView extends StatefulWidget {
  final List<Inner> products;
  final Sale? sale;
  final Customers? customer;

  const SaleProductsListView(
      {Key? key,
      required this.products,
      required this.sale,
      required this.customer})
      : super(key: key);

  @override
  State<SaleProductsListView> createState() => _SaleProductsListViewState();
}

class _SaleProductsListViewState extends State<SaleProductsListView> {
  double _total = 0;

  void _refreshTotal() {
    setState(() {
      _total = 0;
      for (var element in widget.products) {
        _total += element.total;
      }
      AppLog.wtf("-----------'$_total'");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) => SaleWidget(
              inner: widget.products[index],
              refresh: _refreshTotal,
            ),
            itemCount: widget.products.length,
          ),
        )),
        Container(
          color: MyThemes.primary.shade300,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      '???????? ??????:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      NumberFormat.simpleCurrency(name: "???")
                          .format(_total)
                          .toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ButtonWidget(
                  text: '??????????????',
                  onClicked: () async {
                    final Sale saleModel = Sale(
                      id: widget.sale?.id,
                      customerId: widget.customer!.id,
                      customerName: widget.customer!.name,
                      createdAt: DateTime.now().millisecondsSinceEpoch,
                      total: _total,
                    );
                    final saleId = await DatabaseHelper.addSale(saleModel);
                    for (var element in widget.products) {
                      final SaleProduct saleproductModel = SaleProduct(
                        id: widget.sale?.id,
                        saleId: saleId,
                        customerId: widget.customer!.id,
                        productId: widget.customer!.id,
                        productName: element.productId,
                        total: element.total,
                        price: double.parse(element.price),
                        count: element.count,
                      );
                      if (element.count > 0) {
                        await DatabaseHelper.addSaleProduct(saleproductModel);
                      }
                    }

                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SalesScreen()));
                    setState(() {});
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
