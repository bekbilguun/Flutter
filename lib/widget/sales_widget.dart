import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(sale.customerName,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                softWrap: true,
                                textAlign: TextAlign.start),
                            Text(
                                DateFormat.yMMMd().format(
                                    DateTime.parse(sale.createdAt.toString())),
                                softWrap: true,
                                textAlign: TextAlign.left),
                          ],
                        ))),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    NumberFormat.simpleCurrency(name: "₮")
                        .format(sale.total)
                        .toString(),
                    softWrap: true,
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: MyThemes.primary),
                  ),
                )
              ],
            ),
            const Divider(
              thickness: 0.5,
            )
          ],
        ),
      ),
    );
  }
}
