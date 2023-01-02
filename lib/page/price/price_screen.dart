import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/model/customer_model.dart';
import 'package:profile/model/price_model.dart';
import 'package:profile/page/price/product_picker_screen.dart';
import 'package:profile/widget/button_widget.dart';

import '../../themes.dart';

class PriceScreen extends StatefulWidget {
  final Prices? prices;
  final Customers? customer;

  const PriceScreen({Key? key, this.prices, this.customer}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String productId = '';

  void _setProductId(String productId) {
    setState(() {
      this.productId = productId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final priceController = TextEditingController();

    if (widget.prices != null) {
      priceController.text = widget.prices!.price;
    }
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(),
            child: Column(
              children: [
                Stack(
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: ClipPath(
                        // clipper: WaveClipper(),
                        child: Container(
                          color: MyThemes.primary,
                          height: 200,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Row(
                            children: <Widget>[
                              Icon(widget.prices == null ? Icons.add : Icons.edit, color: MyThemes.primary,),
                              const SizedBox(width: 10,),
                              Text(widget.prices == null ? 'Худалдах үнэ' : 'Худалдах үнэ засах',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 18),
                          child: Row(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(),
                                  child: const Text(
                                    'Нэр:',
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    widget.customer!.name,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20),
                          child: Row(
                            children: <Widget>[
                              Align(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(),
                                  child: const Text(
                                    'Бүтээгдэхүүн:',
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Align(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text(
                                    widget.prices != null
                                        ? widget.prices!.productId
                                        : productId,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                widget.prices == null
                    ? Padding(
                        padding:
                            const EdgeInsets.only(right: 40, left: 40, top: 20),
                        child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: ButtonWidget(
                              text: 'Бүтээгдэхүүнээ сонгоно уу',
                              onClicked: widget.prices != null
                                  ? () {}
                                  : () async {
                                      final result = await Navigator.push(
                                        context,
                                        // Create the SelectionScreen in the next step.
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductPickerScreen(
                                                    customer: widget.customer)),
                                      );
                                      _setProductId(result);
                                    },
                            )
                            ),
                      )
                    : const Padding(padding: EdgeInsets.only()),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: TextFormField(
                    controller: priceController,
                    decoration: const InputDecoration(
                        hintText: 'Бүтээгдэхүүний үнэ оруулна уу',
                        labelText: 'үнэ',
                        prefixIcon: Icon(Icons.monetization_on),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.75,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ))),
                    keyboardType: TextInputType.number,
                    onChanged: (str) {},
                    maxLength: 10,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: ButtonWidget(
                        text: widget.prices == null ? 'Нэмэх' : 'Хадгалах',
                        onClicked: () async {
                          final price = priceController.value.text;
                          if (price.isEmpty) {
                            return;
                          }
                          if (widget.prices == null) {
                            final Prices model = Prices(
                                customerId: widget.customer!.id.toString(),
                                productId: productId.toString(),
                                id: widget.prices?.id,
                                price: price);
                            final result = await DatabaseHelper.addPrice(model);
                            if (result == 0) {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                    content: Text('Price бүртгэлтэй байна')));
                            } else {
                              Navigator.pop(context);
                            }
                          } else {
                            final Prices updateModel = Prices(
                                customerId: widget.prices!.customerId,
                                productId: widget.prices!.productId,
                                id: widget.prices?.id,
                                price: price);
                            await DatabaseHelper.updatePrice(updateModel);
                            Navigator.pop(context);
                          }
                          setState(() {});
                        },
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
