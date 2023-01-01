import 'package:flutter/material.dart';
import 'package:profile/model/product_model.dart';
import 'package:profile/db/notes_database.dart';
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
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Products'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProductScreen()));
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<List<Products>?>(
          future: DatabaseHelper.getAllProducts(),
          builder: (context, AsyncSnapshot<List<Products>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
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
                                products: snapshot.data![index],
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
                                      MaterialStateProperty.all(
                                          Colors.red)),
                                  onPressed: () async {
                                    await DatabaseHelper.deleteProduct(
                                        snapshot.data![index]);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: const Text('Yes'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
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
        )
    );
  }
}