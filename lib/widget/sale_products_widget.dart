import 'package:flutter/material.dart';
import 'package:profile/model/sale_product_model.dart';

class SaleProductsWidget extends StatelessWidget {
  final SaleProduct saleProduct;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const SaleProductsWidget(
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
      child: Card(
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(saleProduct.productName.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                       const Align(alignment: Alignment.topRight),
                       const Text(
                          'Нэгж үнэ  ',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Roboto',),
                        ),
                        Text(
                          saleProduct.price.toString(),
                          style:const TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Roboto'),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                       const Align(alignment: Alignment.bottomRight),
                       const Text(
                          'тоо ширхэг  ',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Roboto'),
                        ),
                        Text(saleProduct.count.toString(),
                          style:const TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Roboto'),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                       const Align(alignment: Alignment.topRight),
                       const Text(
                          'Үнэ  ',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Roboto'),
                        ),
                        Text(
                          saleProduct.total.toString(),
                          style:const TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Roboto'),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
