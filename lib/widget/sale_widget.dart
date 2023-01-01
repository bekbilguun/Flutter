import 'package:flutter/material.dart';
import 'package:profile/model/inner_model.dart';

class SaleWidget extends StatefulWidget {
  final Inner inner;
  final Function() refresh;

  const SaleWidget({Key? key, required this.inner, required this.refresh})
      : super(key: key);

  @override
  State<SaleWidget> createState() => _SaleWidgetState();
}

class _SaleWidgetState extends State<SaleWidget> {
  int _count = 0;
  double _total = 0;

  void _sumCount() {
    setState(() {
      _count++;
      _total = double.parse(widget.inner.price) * _count;
      widget.inner.total = _total;
      widget.inner.count = _count;
      widget.refresh();
      print("_________________SUM TOTAL___________________'$_count'___");
    });
  }

  void _minusCount() {
    setState(() {
      if (_count > 0) {
        _count--;
        _total = double.parse(widget.inner.price) * _count;
        widget.inner.total = _total;
        widget.inner.count = _count;
        widget.refresh();
        print("__________________MINUS TOTAL____________________'$_total'___");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(),
              child: Text(widget.inner.productId,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    const Text(
                      'Нэгж үнэ: ',
                      style: TextStyle(fontSize: 12.0, fontFamily: 'Roboto'),
                    ),
                    Text(
                      widget.inner.price,
                      style:
                          const TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
                    ),
                  ],
                ),
                // Row(
                //   children: <Widget>[
                //     const Align(alignment: Alignment.bottomRight),
                //     const Text(
                //       'Нийт үнэ: ',
                //       style: TextStyle(
                //           fontSize: 12.0,
                //           fontFamily: 'Roboto',
                //           color: Color(0xFF9E9E9E)),
                //     ),
                //     Text(
                //       '$_total',
                //       style: const TextStyle(
                //           fontSize: 14.0,
                //           fontFamily: 'Roboto',
                //           color: Color(0xFF212121)),
                //     ),
                //   ],
                // ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: 5),
              child: Row(
                children: <Widget>[
                  const Text(
                    'Авах тоо       ',
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 25,
                    child: ElevatedButton(
                        onPressed: _minusCount,
                        child: const Text(
                          '-',
                          style: TextStyle(fontSize: 21),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      '$_count',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 25,
                    child: ElevatedButton(
                        onPressed: _sumCount,
                        child: const Text("+", style: TextStyle(fontSize: 21))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
