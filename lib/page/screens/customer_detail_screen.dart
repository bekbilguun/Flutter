import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:profile/model/customer_model.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/model/inner_model.dart';
import 'package:profile/page/price/price_screen.dart';
import 'package:profile/page/screens/customer_screen.dart';
import 'package:profile/widget/inner_widget.dart';

import '../../model/price_model.dart';
import '../../themes.dart';
import '../../widget/appbar_widget.dart';


class CustomerDetailScreen extends StatefulWidget {
  final Customers? customer;

  const CustomerDetailScreen({Key? key, this.customer}) : super(key: key);

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    if (widget.customer != null) {
      nameController.text = widget.customer!.name;
      phoneController.text = widget.customer!.phone;
    }

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar:AppBar(
            actions: [
              IconButton(
                icon:const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerScreen(
                                customers: widget.customer,
                              )));
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: MyThemes.primary,
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PriceScreen(customer: widget.customer)));
              setState(() {});
            },
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Opacity(
                      opacity: 0.8,
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
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:<Widget>[
                              Icon(Icons.person_outline, color: MyThemes.iconColor,),
                              const SizedBox(width: 10,),
                              const Text('Хэрэглэгчийн мэдээлэл',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        Padding(
                          padding:const EdgeInsets.all(20),
                          child: Row(
                            children: <Widget>[
                              const Text('Нэр: ',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.customer!.name,
                                style:const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:const EdgeInsets.only(left: 20),
                          child: Row(

                            children: <Widget>[
                              const Text('Утас: ',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.customer!.phone,
                                style:const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 15 ,top: 10),
                  child: Center(
                    child: Text(
                      'Бүтээгдэхүүний лист',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: FutureBuilder<List<Inner>?>(
                      future: DatabaseHelper.innerPriceCustomer(widget.customer),
                      builder: (context, AsyncSnapshot<List<Inner>?> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else if (snapshot.hasData) {
                          if (snapshot.data != null) {
                            print(snapshot.data!.length);

                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) => InnerWidget(
                                inner: snapshot.data![index],
                                onTap: () async {
                                  final Prices priceModel = Prices(
                                      customerId: snapshot.data![index].customerId,
                                      productId: snapshot.data![index].productId,
                                      id: snapshot.data![index].id,
                                      price: snapshot.data![index].price);
                                  final Customers customerModel = Customers(
                                      name: snapshot.data![index].name,
                                      phone: snapshot.data![index].phone,
                                      id: int.parse(snapshot.data![index].customerId));
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PriceScreen(
                                            prices: priceModel,
                                            customer: customerModel,
                                          )));
                                  setState(() {});},
                                onLongPress: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                              'Are you sure you want to delete this note?'),
                                          actions: [
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red)),
                                              onPressed: () async {
                                                await DatabaseHelper.deletePrice(
                                                    snapshot.data![index].id);
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                              child: const Text('Yes'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('No'),
                                            ),
                                          ],
                                        );
                                      });
                                },
                              ),
                              itemCount: snapshot.data!.length,
                            );
                          }
                          return const Center(
                            child: Text('No notes yet'),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
