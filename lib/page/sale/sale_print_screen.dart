import 'dart:io';
import 'dart:typed_data';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/model/sale_model.dart';
import 'package:profile/model/sale_product_model.dart';
import 'package:profile/page/sale/test_screen.dart';
import 'package:profile/utils/app_logger.dart';
import 'package:profile/widget/sale_product_print_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../themes.dart';

class SalePrintScreen extends StatefulWidget {
  final Sale sale;

  const SalePrintScreen({Key? key, required this.sale}) : super(key: key);

  @override
  State<SalePrintScreen> createState() => _SalePrintScreenState();
}

class _SalePrintScreenState extends State<SalePrintScreen> {
  Uint8List? bytes;
  bool play = false;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Хэвлэх'),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: MyThemes.primary,
              onPressed: () async {
                final controller = ScreenshotController();
                final bytes = await controller.captureFromWidget(Material(
                  child: buildCard(),
                ));
                setState(() => {this.bytes = bytes, play = !play});
                saveImage(bytes);
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TestScreen()));
              },
              child: const Icon(Icons.print),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Expanded(
                child: buildCard(),
              ),
            )
            // Stack(
            //   children: <Widget>[
            //     AnimatedPositioned(
            //       curve: Curves.easeInOut,
            //       duration: const Duration(milliseconds: 1200),
            //       height: play ? 200 : 0,
            //       child: Card(
            //           elevation: 5,
            //           // color: Colors.green,
            //           margin: EdgeInsets.all(30),
            //           child: Expanded(child: buildCard())),
            //     )
            //   ],
            // )
            ),
      ),
    );
  }

  buildCard() => Padding(
      padding: const EdgeInsets.all(10),
      child: Expanded(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Lambda XXK",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [const Text("ТТД : "), Text(widget.sale.id.toString())],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Талон : "),
                    Text(widget.sale.id.toString()),
                  ],
                ),
                Row(
                  children: const [Text("Кассир : "), Text("Pos3 /Дэлгүүр/")],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text("Огноо : "),
                    Text(
                      DateFormat.yMd()
                          .format(DateTime.fromMillisecondsSinceEpoch(
                              widget.sale.createdAt))
                          .toString(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text("Цаг : "),
                    Text(
                      DateFormat.jms()
                          .format(DateTime.fromMillisecondsSinceEpoch(
                              widget.sale.createdAt))
                          .toString(),
                    ),
                  ],
                )
              ],
            ),
            const Divider(thickness: 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("T"),
                Text("Бараа"),
                Text("Үнэ"),
                Text("Tоо"),
                Text("Дүн"),
              ],
            ),
            const Divider(thickness: 0.5),
            FutureBuilder<List<SaleProduct>?>(
              future: DatabaseHelper.getAllSaleProducts(widget.sale),
              builder: (context, AsyncSnapshot<List<SaleProduct>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
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
                      itemBuilder: (context, index) => SaleProductPrintWidget(
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
            const Divider(thickness: 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Нийт : Бараа(ууд)"),
                Text(widget.sale.total.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Төлөх :"),
                Text(widget.sale.total.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Бэлэн :"),
                Text(widget.sale.total.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text("Хариулт :"), Text("0")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("НӨАТ : 10%"),
                Text((widget.sale.total).toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text("Сугалаа : "), Text("KX 52317354")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Ebarimt дүн : "),
                Text((widget.sale.total).toString())
              ],
            ),
            const Divider(thickness: 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text("ДДТД : "),
                Text("002013156102031561561203")
              ],
            ),
            //----------QR----------
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  QrImage(
                    data: widget.sale.customerName,
                    version: QrVersions.auto,
                    size: 150,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Сугалаа:"),
                              Text("KX 52317354"),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Ebarimt.mn дүн: "),
                              Text((widget.sale.total).toString())
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                  height: 50,
                  child:
                      SfBarcodeGenerator(value: 'http://www.syncfusion.com')),
            ),
          ],
        ),
      ));

  Future saveImage(Uint8List bytes) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/image.png');
    AppLog.debug(file);
    file.writeAsBytes(bytes);
  }

  Future loadImage() async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/image.png');
    if (file.existsSync()) {
      final bytes = await file.readAsBytes();
      setState(() => this.bytes = bytes);
    }
  }
}
