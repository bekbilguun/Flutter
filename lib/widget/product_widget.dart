import 'package:flutter/material.dart';
import 'package:profile/model/product_model.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
        child: Card(
          elevation: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  child: Text(
                    products.name,
                    style: const TextStyle(fontSize: 20),
                    softWrap: true,
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
                          ],
                        )
                      ]),
                    ),
                    Align(
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 18),
                          child: const Icon(Icons.arrow_right_outlined)),
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
