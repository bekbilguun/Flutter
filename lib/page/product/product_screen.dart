import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/model/product_model.dart';
import 'package:profile/themes.dart';
import 'package:profile/widget/appbar_widget.dart';

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
          appBar:
          AppBar(
            title: Text( products == null
                ? 'Add a product'
                : 'Edit product'
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: ClipPath(
                        child: Container(
                          color: MyThemes.primary,
                          height: 200,
                        ),
                      ),
                    ),
                    Container(
                      color: MyThemes.primary,
                      height: 200,
                      child:Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Icon(
                              Icons.store_mall_directory_outlined,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Бүтээгдэхүүн',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30, top: 30),
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
                Padding(padding: const EdgeInsets.only(left: 30,right: 30, top: 30),
                child:TextFormField(
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
                ),),

                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30, bottom: 30),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
