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
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
        child: Card(
          elevation: 5,
          child:Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: const Text('Хэрэглэгч',
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w300)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    child: Container(
                      padding:
                      const EdgeInsets.all(10),
                      child: Text(
                        customer.name,
                        style: const TextStyle(fontSize: 20),
                        softWrap: true,
                      ),
                    ),
                  ),
                  Align(
                    child: Container(
                      padding:
                      const EdgeInsets.all(10),
                      child: Icon(
                        Icons.arrow_forward,
                        color: MyThemes.iconColor,
                        shadows:const [Shadow(blurRadius: 1)],
                      ),
                    ),
                  ),

                ],
              ),
            ],
          )

        ),
      ),
    );
  }
}
