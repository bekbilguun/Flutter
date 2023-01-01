import 'package:flutter/material.dart';
import 'package:profile/model/price_model.dart';

class PricesWidget extends StatelessWidget {
  final Prices prices;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const PricesWidget(
      {Key? key,
      required this.prices,
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
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    prices.price,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Text(prices.customerId,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Text(prices.productId,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
