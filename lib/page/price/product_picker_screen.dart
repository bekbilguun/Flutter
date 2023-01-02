import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:profile/model/customer_model.dart';
import 'package:profile/model/product_model.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/widget/product_widget.dart';
import 'dart:async';

class ProductPickerScreen extends StatefulWidget {
  final Customers? customer;

  const ProductPickerScreen({Key? key, this.customer}) : super(key: key);

  @override
  State<ProductPickerScreen> createState() => ProductPickerScreenState();
}
class Debounce {
  Duration delay;
  Timer? _timer;

  Debounce(
      this.delay,
      );

  call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  dispose() {
    _timer?.cancel();
  }
}

class ProductPickerScreenState extends State<ProductPickerScreen> {
  final Debounce _debounce = Debounce(Duration(milliseconds: 1000));
  Icon customIcon = const Icon(Icons.search);
  String keyword = "";

  void _setKeyword(String keyword) {
    setState(() {
      this.keyword = keyword;
      print(
          '----------------customSearchBar---------------------customSearchBar');
      print(keyword);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context)=> Scaffold(
            appBar: AppBar(title: Text('Product picker'), centerTitle: true),
            body: Padding(
                padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black87,
                            ),
                            hintText: "Бүтээглэхүүны нэр",
                            hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 15)),
                        onChanged: (value) => {
                          _debounce((){
                            _setKeyword(value);
                          })},
                      ),
                    ),
                    Expanded(
                        child: FutureBuilder<List<Products>?>(
                          // future: DatabaseHelper.getPikerProducts(widget.customer),
                          future: DatabaseHelper.getSearchProducts(keyword),
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
                                    onTap: () => Navigator.pop(
                                        context, snapshot.data![index].name),
                                    onLongPress: () async {},
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
                        )),
                  ],
                ))
        ),
      ),
        );
  }
}
