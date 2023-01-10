import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profile/model/sale_product_model.dart';

class SaleProductPrintWidget extends StatelessWidget {
  final SaleProduct saleProduct;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const SaleProductPrintWidget(
      {Key? key,
      required this.saleProduct,
      required this.onTap,
      required this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("01"),
          Text(saleProduct.productName.toString()),
          Text(saleProduct.price.toString()),
          Text(saleProduct.count.toString()),
          Text(saleProduct.total.toString()),
        ],
      ),
    );
  }
}
