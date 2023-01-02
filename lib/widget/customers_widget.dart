import 'package:flutter/material.dart';
import 'package:profile/model/customer_model.dart';

class CustomerWidget extends StatelessWidget {
  final Customers customer;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const CustomerWidget(
      {Key? key,
      required this.customer,
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
                    customer.name,
                    style: const TextStyle(fontSize: 20),
                    softWrap: true,
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Align(
                    //   child: Container(
                    //     padding:
                    //     const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                    //     child: Text(
                    //       customer.phone,
                    //       softWrap: true,
                    //       textAlign: TextAlign.end,
                    //     ),
                    //   ),
                    // ),
                    Row(
                      children: const <Widget>[
                        // Text("Дэлгэрэнгүй"),
                        Icon(
                          Icons.arrow_right_outlined,
                          shadows: [Shadow(blurRadius: 1)],
                        ),
                      ],
                    ),
                    // Align(
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 18, vertical: 18),
                    //     child: Icon(
                    //       Icons.arrow_right_outlined,
                    //       shadows: [Shadow(blurRadius: 1)],
                    //     ),
                    //   ),
                    // ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
