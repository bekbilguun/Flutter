import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:profile/model/customer_model.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/page/sale/sale_product_screen.dart';
import 'package:profile/page/sale/sales_screen.dart';
import 'package:profile/widget/customers_widget.dart';

import '../../themes.dart';
import '../../widget/AuthClipper_widget.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({Key? key}) : super(key: key);

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
          builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Худалдан авагч',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.list,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SalesScreen()));
                    },
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Opacity(
                          opacity: 0.8,
                          child: ClipPath(
                            clipper: AuthClipper(),
                            child: Container(
                              color: MyThemes.primary,
                              height: 100,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: FutureBuilder<List<Customers>?>(
                        future: DatabaseHelper.getAllCustomers(),
                        builder: (context,
                            AsyncSnapshot<List<Customers>?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(snapshot.error.toString()));
                          } else if (snapshot.hasData) {
                            if (snapshot.data != null) {
                              print(snapshot.data);
                              return ListView.builder(
                                itemBuilder: (context, index) => CustomerWidget(
                                  customer: snapshot.data![index],
                                  onTap: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SaleProductScreen(
                                                    customer: snapshot
                                                        .data![index])));
                                    setState(() {});
                                  },
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
                                                        MaterialStateProperty
                                                            .all(Colors.red)),
                                                onPressed: () async {
                                                  await DatabaseHelper
                                                      .deleteCustomer(snapshot
                                                          .data![index]);
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
                    ))
                  ],
                ),
              ))),
    );
  }
}
