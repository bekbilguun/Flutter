import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/model/sale_model.dart';
import 'package:profile/model/sale_product_model.dart';
import 'package:profile/widget/sale_products_widget.dart';


class SaleDetailScreen extends StatefulWidget {
  final Sale? sale;

  const SaleDetailScreen({Key? key, this.sale}) : super(key: key);

  @override
  State<SaleDetailScreen> createState() => _SaleDetailScreenState();
}

class _SaleDetailScreenState extends State<SaleDetailScreen> {
  @override
  Widget build(BuildContext context) {

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title:const Text('Sale detail products'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      Row(
                        children: <Widget>[
                          Icon(Icons.person, color: Colors.blue,),
                          SizedBox(width: 10,),
                          Text('Хэрэглэгчийн мэдээлэл',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(indent: 10, endIndent: 10, height: 1, thickness: 1, color: Colors.grey),
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Row(
                        children: <Widget>[
                          const  Text('Нэр: ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(this.widget.sale!.customerName,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Row(
                        children: <Widget>[
                          const Text('Нийт үнэ: ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(this.widget.sale!.total.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Row(
                        children: <Widget>[
                          const  Text('Огноо: ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(this.widget.sale!.createdAt.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 15 ,top: 10),
                  child: Center(
                    child: Text(
                      'Худалдан авсан бүтээгдэхүүн',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Divider(indent: 10,endIndent: 10,height: 1, thickness: 1, color: Colors.grey),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<List<SaleProduct>?>(
                      future: DatabaseHelper.getAllSaleProducts(widget.sale),
                      builder: (context, AsyncSnapshot<List<SaleProduct>?> snapshot) {
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
                              itemBuilder: (context, index) => SaleProductsWidget(
                                saleProduct: snapshot.data![index],
                                onTap: () async {},
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
