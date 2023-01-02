import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:profile/model/customer_model.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/page/screens/customer_detail_screen.dart';
import 'package:profile/widget/customers_widget.dart';
import '../../themes.dart';
import '../../widget/appbar_widget.dart';
import 'customer_screen.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
            appBar: AppBar(centerTitle: false),
            floatingActionButton: FloatingActionButton(
              backgroundColor: MyThemes.primary,
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomerScreen()));
                setState(() {});
              },
              child: const Icon(Icons.add),
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
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Icon(
                              Icons.person_outline,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Хэрэглэгчид',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                      child: FutureBuilder<List<Customers>?>(
                      future: DatabaseHelper.getAllCustomers(),
                      builder:
                          (context, AsyncSnapshot<List<Customers>?> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else if (snapshot.hasData) {
                          if (snapshot.data != null) {
                            print(snapshot.data);
                            return ListView.builder(
                              itemBuilder: (context, index) => CustomerWidget(
                                customer: snapshot.data![index],
                                onTap: () async {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CustomerDetailScreen(
                                                  customer:
                                                      snapshot.data![index])));
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
                                                await DatabaseHelper
                                                    .deleteCustomer(
                                                        snapshot.data![index]);
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
                  ))
                ],
              ),
            )),
      ),
    );
  }
}

// class WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//   debugPrint(size.width.toString());
//   var path = new Path();
//   path.lineTo(0, size.height);
//   var firstStart = Offset(size.width / 5, size.height);
//   var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
//   path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
//   var secondStart = Offset(size.width - (size.width / 3.24), size.height - 105);
//   var secondEnd = Offset(size.width,size.height -10);
//   path.quadraticBezierTo(secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
//   path.lineTo(size.width, 0);
//   path.close();
//   return path;
//   }
// }
