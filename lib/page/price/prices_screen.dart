import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:profile/model/price_model.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/widget/prices_widget.dart';
import 'price_screen.dart';

class PricesScreen extends StatefulWidget {
  const PricesScreen({Key? key}) : super(key: key);

  @override
  State<PricesScreen> createState() => PricesScreenState();
}

class PricesScreenState extends State<PricesScreen> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('PRICES'),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PriceScreen()));
                setState(() {});
              },
              child: const Icon(Icons.add),
            ),
            body: FutureBuilder<List<Prices>?>(
              future: DatabaseHelper.getAllPrice(),
              builder: (context, AsyncSnapshot<List<Prices>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemBuilder: (context, index) => PricesWidget(
                        prices: snapshot.data![index],
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PriceScreen(
                                        prices: snapshot.data![index],
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
                                        await DatabaseHelper.deletePrice(
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
            )),
      ),
    );
  }
}
