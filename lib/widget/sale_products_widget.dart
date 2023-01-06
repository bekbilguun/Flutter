import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(),
                  child: Text(saleProduct.productName.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                )),
                Row(
                  children: <Widget>[
                    const Align(alignment: Alignment.bottomRight),
                    const Text(
                      'тоо ширхэг:  ',
                      style: TextStyle(fontSize: 12.0, fontFamily: 'Roboto'),
                    ),
                    Text(
                      saleProduct.count.toString(),
                      style: const TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Text(
                          'Нэгж үнэ: ',
                          style:
                              TextStyle(fontSize: 12.0, fontFamily: 'Roboto'),
                        ),
                        Text(
                          NumberFormat.simpleCurrency(name: "₮").format(saleProduct.price).toString(),
                          style: const TextStyle(
                              fontSize: 14.0, fontFamily: 'Roboto'),
                        ),
                      ],
                    ),
                  ]),
                ),
                Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Align(alignment: Alignment.topRight),
                              const Text(
                                'Үнэ  ',
                                style: TextStyle(
                                    fontSize: 12.0, fontFamily: 'Roboto'),
                              ),
                              Text(
                                NumberFormat.simpleCurrency(name: "₮").format(saleProduct.total).toString(),
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ])),
              ],
            ),
            const Divider(
              thickness: 0.5,
            )
          ])),
    );
  }
}
