import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/model/sale_model.dart';
import 'package:profile/page/sale/sale_detail_screen.dart';
import 'package:profile/widget/sales_widget.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Sales'),
              centerTitle: true,
            ),
            body: FutureBuilder<List<Sale>?>(
              future: DatabaseHelper.getAllSales(),
              builder: (context, AsyncSnapshot<List<Sale>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    print(snapshot.data);
                    return ListView.builder(
                      itemBuilder: (context, index) => SalesWidget(
                        sale: snapshot.data![index],
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SaleDetailScreen(
                                      sale: snapshot.data![index])));
                          setState(() {});
                        },
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
      ),
    );
  }
}
