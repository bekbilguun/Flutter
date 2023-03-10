import 'package:flutter/material.dart';
import 'package:profile/model/customer_model.dart';
import 'package:profile/themes.dart';

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
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          customer.name,
                          style: const TextStyle(fontSize: 20),
                          softWrap: true,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: MyThemes.iconColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 0.5,
              )
            ],
          )),
    );
  }
}
