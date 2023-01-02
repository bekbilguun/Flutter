import 'package:flutter/material.dart';
import 'package:profile/model/inner_model.dart';

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
      child: Card(
        elevation: 5,
          child:Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: const Text('Бүтээгдэхүүн',
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w300)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                    fontSize: 12.0,
                                    fontFamily: 'Roboto'),
                              ),
                              Text(
                                inner.price,
                                style:const TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Roboto'),
                              ),
                            ],
                          ),
                          Row(
                            children:const <Widget>[
                              Align(alignment: Alignment.bottomRight),
                              Text(
                                'тоо ширхэг  ',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Roboto'),
                              ),
                              Text(
                                '50',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Roboto'),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ],
              ),
            ],
          )

      ),
    );
  }
}
