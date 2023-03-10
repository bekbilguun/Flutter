import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/model/sale_model.dart';
import 'package:profile/model/sale_product_model.dart';
import 'package:profile/page/sale/sale_print_screen.dart';
import 'package:profile/utils/app_logger.dart';
import 'package:profile/widget/sale_products_widget.dart';
import '../../themes.dart';
import '../../widget/AuthClipper_widget.dart';

class SaleDetailScreen extends StatefulWidget {
  final Sale sale;

  const SaleDetailScreen({Key? key, required this.sale}) : super(key: key);

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
            title: Row(
              children: [
                const Text('Sale detail'),
                Expanded(
                    child: Text(
                  widget.sale.customerName,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ))
              ],
            ),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: MyThemes.primary,
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SalePrintScreen(
                            sale: widget.sale,
                          )));
              setState(() {});
            },
            child: const Icon(Icons.print),
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
                        clipper: AuthClipper(),
                        child: Container(
                          color: MyThemes.primary,
                          height: 100,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Row(
                            children: [
                              Row(
                                children: <Widget>[
                                  const Text(
                                    '???????? ??????: ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    NumberFormat.simpleCurrency(name: "???")
                                        .format(widget.sale.total)
                                        .toString(),
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Row(
                                children: <Widget>[
                                  const Text(
                                    '??????????: ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    DateFormat.yMMMd()
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                widget.sale.createdAt))
                                        .toString(),
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Center(
                    child: Text(
                      '???????????????? ?????????? ????????????????????????',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: FutureBuilder<List<SaleProduct>?>(
                      future: DatabaseHelper.getAllSaleProducts(widget.sale),
                      builder: (context,
                          AsyncSnapshot<List<SaleProduct>?> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else if (snapshot.hasData) {
                          if (snapshot.data != null) {
                            AppLog.debug(snapshot.data!.length);
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  SaleProductsWidget(
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
                // Padding(
                //   padding: EdgeInsets.only(bottom: 20),
                //   child: ButtonWidget(
                //       text: '????????????',
                //       onClicked: () async {
                //         await Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => SalePrintScreen(sale: widget.sale)));
                //         setState(() {});
                //       }),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
