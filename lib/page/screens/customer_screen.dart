import 'package:flutter/material.dart';
import 'package:profile/model/customer_model.dart';
import 'package:profile/db/notes_database.dart';
import 'customers_screen.dart';

class CustomerScreen extends StatelessWidget {
  final Customers? customers;

  const CustomerScreen({Key? key, this.customers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    if (customers != null) {
      nameController.text = customers!.name;
      phoneController.text = customers!.phone;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(customers == null ? 'Add a customer' : 'Edit customer'),
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
                    prefixIcon: Icon(Icons.person),
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
              controller: phoneController,
              decoration: const InputDecoration(
                  hintText: 'Type here the phone',
                  labelText: 'phone',
                  prefixIcon: Icon(Icons.phone),
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
              maxLength: 8,
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
                      final phone = phoneController.value.text;

                      if (name.isEmpty || phone.isEmpty) {
                        return;
                      }

                      final Customers model = Customers(
                          name: name, phone: phone, id: customers?.id);
                      if (customers == null) {
                        await DatabaseHelper.addCustomer(model);
                      } else {
                        await DatabaseHelper.updateCustomer(model);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomersScreen()));
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
                    child: Text(
                      customers == null ? 'Add' : 'Save',
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
