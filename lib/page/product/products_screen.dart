import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:profile/model/product_model.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/widget/appbar_widget.dart';
import 'package:profile/widget/product_widget.dart';
import 'product_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
            appBar:
            // buildAppBar(context),
            AppBar(
              title: const Text('Products'),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductScreen()));
                setState(() {});
              },
              child: const Icon(Icons.add),
            ),
            body: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.store_mall_directory_outlined,
                          color: Colors.blue,
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
                  const Divider(
                      height: 5,
                      thickness: 1,
                      color: Colors.grey,
                      indent: 10,
                      endIndent: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: FutureBuilder<List<Products>?>(
                        future: DatabaseHelper.getAllProducts(),
                        builder:
                            (context, AsyncSnapshot<List<Products>?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(snapshot.error.toString()));
                          } else if (snapshot.hasData) {
                            if (snapshot.data != null) {
                              return ListView.builder(
                                itemBuilder: (context, index) => ProductWidget(
                                  products: snapshot.data![index],
                                  onTap: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductScreen(
                                                  products:
                                                      snapshot.data![index],
                                                )));
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
                                                      .deleteProduct(snapshot
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
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
