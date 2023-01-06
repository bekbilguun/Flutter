import 'package:flutter/material.dart';
import 'package:profile/model/product_model.dart';
import 'package:profile/themes.dart';

class ProductWidget extends StatelessWidget {
  final Products products;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const ProductWidget(
      {Key? key,
      required this.products,
      required this.onTap,
      required this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        child: Text(
                          products.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          softWrap: true,
                        ),
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                          child: Column(children: <Widget>[
                            Row(
                              children: <Widget>[
                                const Text('Баркод: '),
                                Text(
                                  products.barcode,
                                  softWrap: true,
                                  textAlign: TextAlign.end,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: MyThemes.iconColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            )
                          ]),
                        ),
                      ]),
                ],
              ),
              const Divider(
                thickness: 0.5,
              )
            ],
          )),
    );
  }
}
