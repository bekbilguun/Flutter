import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:profile/model/customer_model.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/widget/button_widget.dart';
import '../../themes.dart';
import '../../widget/AuthClipper_widget.dart';
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

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar:
          AppBar(),
          body:Padding(
            padding: const EdgeInsets.symmetric(),
            child: Column(
              children: [
                Stack(
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: ClipPath(
                        clipper: AuthClipper(),
                        child: Container(
                          color: MyThemes.primary,
                          height: 200,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(customers == null ? Icons.add : Icons.edit, color: MyThemes.iconColor,),
                          const SizedBox(width: 10,),
                          Text(customers == null ? 'Хэрэглэгч нэмэх' : 'Хэрэглэгч засах',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
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
                Padding(padding: const EdgeInsets.only(left: 30, right: 30, top: 30),child:
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
                ),),
                const Spacer(),
                Expanded(child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: ButtonWidget(
                        text: customers == null ? 'Нэмэх' : 'Хадгалах',
                        onClicked: () async {
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
                      ),
                    ),
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
