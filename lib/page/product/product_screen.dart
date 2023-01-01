import 'package:flutter/material.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/model/product_model.dart';

class ProductScreen extends StatelessWidget {
  final Products? products;
  const ProductScreen({
    Key? key,
    this.products
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final barcodeController = TextEditingController();

    if(products != null){
      nameController.text = products!.name;
      barcodeController.text = products!.barcode;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text( products == null
            ? 'Add a product'
            : 'Edit product'
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0, top: 30),
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
            TextFormField(
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
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      final name = nameController.value.text;
                      final barcode = barcodeController.value.text;

                      if (name.isEmpty || barcode.isEmpty) {
                        return;
                      }

                      final Products model = Products(name: name, barcode: barcode, id: products?.id);
                      if(products == null){
                        await DatabaseHelper.addProduct(model);
                      }else{
                        await DatabaseHelper.updateProduct(model);
                      }

                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 0.75,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                )))),
                    child: Text( products == null
                        ? 'Save' : 'Save',
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}