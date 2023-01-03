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
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Card(
          elevation: 0,
          child:Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Column(
                          children: [
                            Padding(padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              sale.customerName,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              softWrap: true,
                            ),),
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: Row(
                                children: <Widget>[
                                  const Text('Огноо: '),
                                  Text(sale.createdAt.toString(),
                                      softWrap: true,
                                      textAlign: TextAlign.end),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      sale.total.toString(),
                      softWrap: true,
                      textAlign: TextAlign.end,
                      style:
                      const TextStyle(color: MyThemes.primary),
                    ),
                  )

                ],
              ),
              const Divider(thickness: 0.5,)
            ],
          )
        ),
      ),
    );
  }
}
