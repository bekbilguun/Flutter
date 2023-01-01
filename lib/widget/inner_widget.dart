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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: new EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(inner.productId,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Container(
                alignment: Alignment.centerRight,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                    Row(
                      children: <Widget>[
                        Align(alignment: Alignment.topRight),
                        Text(
                          'Үнэ',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Roboto',
                              color: new Color(0xFF9E9E9E)),
                        ),
                        Text(
                          inner.price,
                          style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Roboto',
                              color: Color(0xFF212121)),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Align(alignment: Alignment.bottomRight),
                        Text(
                          'тоо ширхэг  ',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Roboto',
                              color: Color(0xFF9E9E9E)),
                        ),
                        Text(
                          '50',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Roboto',
                              color: Color(0xFF212121)),
                        ),
                      ],
                    ),
                  ]),
              ),
              Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 18),
                  child: Icon(Icons.edit)
              ),
            ],
        ),
      ),
    );
  }
}
