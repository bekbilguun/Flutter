import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profile/widget/sales_widget.dart';

import '../model/sale_model.dart';
import '../page/sale/sale_detail_screen.dart';
import '../themes.dart';

class TabViewsWidget extends StatelessWidget {
  final futureList;
  final futureStats;

  const TabViewsWidget({
    Key? key,
    required this.futureList,
    required this.futureStats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: FutureBuilder<List<Sale>?>(
          future: futureList,
          builder: (context, AsyncSnapshot<List<Sale>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                // _setCount(snapshot.data!.length);
                return ListView.builder(
                  itemBuilder: (context, index) => SalesWidget(
                    sale: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SaleDetailScreen(
                                  sale: snapshot.data![index])));
                    },
                    onLongPress: () {},
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
        Container(
          color: MyThemes.primary.shade300,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(
                      'Тоо',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.purple),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(
                      'Нийт үнэ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              FutureBuilder<dynamic>(
                future: futureStats,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<dynamic> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      print(
                          "___________________________________snapshot.data.toString()");
                      print(snapshot.data.toString());

                      return Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data['count'].toString(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold,color: Colors.purple),
                              ),
                              Text(
                                NumberFormat.simpleCurrency(name: "₮")
                                    .format(snapshot.data['total'] ?? 0)
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ));
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
