import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/model/sale_model.dart';
import 'package:profile/model/sale_product_model.dart';
import 'package:profile/widget/sale_products_widget.dart';

import '../../themes.dart';


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
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: ClipPath(
                        // clipper: WaveClipper(),
                        child: Container(
                          color: MyThemes.primary,
                          height: 200,
                          child:Column(
                            children: [
                              Padding(
                                padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.contact_mail_sharp, color: MyThemes.iconColor),
                                        const SizedBox(width: 10),
                                        Text(widget.sale!.customerName,style:const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              //   child: Row(
                              //     children: [
                              //       Row(
                              //         children: <Widget>[
                              //           const  Text('Нэр: ',
                              //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              //           ),
                              //           Text(widget.sale!.customerName,
                              //             style:const TextStyle(fontSize: 18),
                              //           ),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Padding(
                                padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                child: Row(
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.monetization_on,color: MyThemes.iconColor),
                                        const SizedBox(width: 5),
                                        const Text('Нийт үнэ: ',
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        Text(widget.sale!.total.toString(),
                                          style:const TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.date_range_outlined,color: MyThemes.iconColor),
                                        const SizedBox(width: 5),
                                        const  Text('Огноо: ',
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        Text(widget.sale!.createdAt.toString(),
                                          style:const TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                    )
                  ],
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Center(
                    child: Text(
                      'Худалдан авсан бүтээгдэхүүн',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
