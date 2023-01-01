import 'package:flutter/material.dart';
import 'package:profile/model/sale_model.dart';

class SalesWidget extends StatelessWidget {
  final Sale sale;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const SalesWidget(
      {Key? key,
      required this.sale,
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
          elevation: 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  child: Text(
                    sale.customerName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[
                                Text('Худалтан: '),
                                Text(
                                  sale.total.toString(),
                                  softWrap: true,
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            )),
                        Row(
                          children: <Widget>[
                            Text('Огноо: '),
                            Text(
                              sale.createdAt.toString(),
                              softWrap: true,
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ],
                    )
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
