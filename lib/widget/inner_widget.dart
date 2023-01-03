import 'package:flutter/material.dart';
import 'package:profile/model/inner_model.dart';
import 'package:profile/themes.dart';

class InnerWidget extends StatelessWidget {
  final Inner inner;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const InnerWidget(
      {Key? key,
      required this.inner,
      required this.onTap,
      required this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onLongPress: onLongPress,
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(25),
                      child: Text(inner.productId,
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
                                  'Үнэ  ',
                                  style: TextStyle(
                                      fontSize: 12.0, fontFamily: 'Roboto'),
                                ),
                                Text(
                                  inner.price,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: 'Roboto',
                                      color: MyThemes.primary),
                                ),
                              ],
                            ),
                            Row(
                              children: const <Widget>[
                                Align(alignment: Alignment.bottomRight),
                                Text(
                                  'тоо ширхэг  ',
                                  style: TextStyle(
                                      fontSize: 12.0, fontFamily: 'Roboto'),
                                ),
                                Text(
                                  '50',
                                  style: TextStyle(
                                      fontSize: 14.0, fontFamily: 'Roboto'),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 0.5,
                )
              ],
            )));
  }
}
