import 'package:flutter/material.dart';
import 'package:profile/model/sale_model.dart';
import 'package:profile/themes.dart';

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
          child:Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: const Text('Худалтан авалт',
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w300)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              sale.customerName,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              softWrap: true,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  const Text('Огноо: '),
                                  Text(sale.createdAt.toString(),
                                      softWrap: true,
                                      textAlign: TextAlign.end,
                                      style:
                                      const TextStyle(color: MyThemes.primary)),
                                ],
                              ),
                            )
                          ],
                        )),
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
                                    const Text('Худалтан авалт: '),
                                    Text(
                                      sale.total.toString(),
                                      softWrap: true,
                                      textAlign: TextAlign.end,
                                      style:
                                      const TextStyle(color: MyThemes.primary),
                                    ),
                                  ],
                                )),
                          ],
                        )
                      ]),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}
