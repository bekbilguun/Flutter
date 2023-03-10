import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profile/model/inner_model.dart';
import 'package:profile/themes.dart';
import 'package:profile/utils/app_logger.dart';

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
      AppLog.debug("_________________SUM TOTAL___________________'$_count'___");
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
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.inner.productId,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          Row(
                            children: <Widget>[
                              const Text(
                                '???????? ??????: ',
                                style: TextStyle(
                                    fontSize: 12.0, fontFamily: 'Roboto'),
                              ),
                              Text(
                                NumberFormat.simpleCurrency(name: "???")
                                    .format(int.parse(widget.inner.price))
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Roboto',
                                    color: MyThemes.primary),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: _minusCount,
                                child: const Text(
                                  '-',
                                  style: TextStyle(fontSize: 21),
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              '$_count',
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: _sumCount,
                                child: const Text("+",
                                    style: TextStyle(fontSize: 21))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
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
