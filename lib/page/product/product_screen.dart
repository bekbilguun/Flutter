import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/model/product_model.dart';
import '../../widget/button_widget.dart';

class ProductScreen extends StatelessWidget {
  final Products? products;

  const ProductScreen({Key? key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final barcodeController = TextEditingController();

    if (products != null) {
      nameController.text = products!.name;
      barcodeController.text = products!.barcode;
    }

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(
              products == null ? 'Бүтээгдэхүүн нэмэх' : 'Бүтээгдэхүүн засах',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                  child: TextFormField(
                    controller: nameController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        hintText: 'name',
                        labelText: 'name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.75,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                  child: TextFormField(
                    controller: barcodeController,
                    decoration: const InputDecoration(
                        hintText: 'Type here the barcode',
                        labelText: 'barcode',
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
                    // maxLines: 5,
                  ),
                ),
                const Spacer(),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                    child: SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: ButtonWidget(
                          text: products == null ? 'Нэмэх' : 'Хадгалах',
                          onClicked: () async {
                            final name = nameController.value.text;
                            final barcode = barcodeController.value.text;

                            if (name.isEmpty || barcode.isEmpty) {
                              return;
                            }

                            final Products model = Products(
                                name: name, barcode: barcode, id: products?.id);
                            if (products == null) {
                              await DatabaseHelper.addProduct(model);
                            } else {
                              await DatabaseHelper.updateProduct(model);
                            }
                            Navigator.pop(context);
                          },
                        )),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
