import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/model/sale_model.dart';
import 'package:profile/page/sale/sale_detail_screen.dart';
import 'package:profile/widget/sales_widget.dart';

import '../../themes.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  int _count = 0;
  double _total = 0;
  DateTime now = DateTime.now();

  _getStartDate(int day) {
    DateTime startDate = DateTime(now.year, now.month, now.day - 1 * day);
    return startDate;
  }

  _getEndDate(int day) {
    DateTime endDate = DateTime(now.year, now.month, now.day - 1 * day, 24);
    return endDate;
  }

  _getDetail(int count, double total) {
    _count = count;
    _total = total;
    return _count;
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
        child: DefaultTabController(
      length: 4,
      child: Builder(
        builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Sales'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TabBar(
                        tabs: [
                          Tab(
                            child: Text(
                              'Today',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'YesDay',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Week',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Month',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        //today
                        Column(
                          children: [
                            Expanded(
                                child: FutureBuilder<List<Sale>?>(
                              future: DatabaseHelper.getSales(
                                  _getStartDate(0), _getEndDate(0)),
                              builder: (context,
                                  AsyncSnapshot<List<Sale>?> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text(snapshot.error.toString()));
                                } else if (snapshot.hasData) {
                                  if (snapshot.data != null) {
                                    // _setCount(snapshot.data!.length);
                                    return ListView.builder(
                                      itemBuilder: (context, index) =>
                                          SalesWidget(
                                        sale: snapshot.data![index],
                                        onTap: () async {
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SaleDetailScreen(
                                                          sale: snapshot
                                                              .data![index])));
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
                            Card(
                              color: MyThemes.primary.shade300,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Text(
                                          'Тоо',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Text(
                                          'Нийт үнэ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  FutureBuilder<dynamic>(
                                    future: DatabaseHelper.getSaleStats(
                                        _getStartDate(0), _getEndDate(0)),
                                    builder: (
                                      BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot,
                                    ) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return const Text('Error');
                                        } else if (snapshot.hasData) {
                                          print(
                                              "___________________________________snapshot.data.toString()");
                                          print(snapshot.data.toString());
                                          // _getDetail(int.parse(snapshot.data['count']),double.parse(snapshot.data['total']));
                                          return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data['count']
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    NumberFormat.simpleCurrency(
                                                            name: "₮")
                                                        .format(snapshot
                                                            .data['total'])
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ));
                                        } else {
                                          return const Text('Empty data');
                                        }
                                      } else {
                                        return Text(
                                            'State: ${snapshot.connectionState}');
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        //yesterday
                        Column(
                          children: [
                            Expanded(
                              child: FutureBuilder<List<Sale>?>(
                                future: DatabaseHelper.getSales(
                                    _getStartDate(1), _getEndDate(1)),
                                builder: (context,
                                    AsyncSnapshot<List<Sale>?> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child: Text(snapshot.error.toString()));
                                  } else if (snapshot.hasData) {
                                    if (snapshot.data != null) {
                                      return ListView.builder(
                                        itemBuilder: (context, index) =>
                                            SalesWidget(
                                          sale: snapshot.data![index],
                                          onTap: () async {
                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SaleDetailScreen(
                                                            sale:
                                                                snapshot.data![
                                                                    index])));
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
                              ),
                            ),
                            Card(
                              color: MyThemes.primary.shade300,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Text(
                                          'Тоо',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Text(
                                          'Нийт үнэ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  FutureBuilder<dynamic>(
                                    future: DatabaseHelper.getSaleStats(
                                        _getStartDate(1), _getEndDate(1)),
                                    builder: (
                                      BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot,
                                    ) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return const Text('Error');
                                        } else if (snapshot.hasData) {
                                          print(
                                              "___________________________________snapshot.data.toString()");
                                          print(snapshot.data.toString());
                                          // _getDetail(int.parse(snapshot.data['count']),double.parse(snapshot.data['total']));
                                          return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data['count']
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    NumberFormat.simpleCurrency(
                                                            name: "₮")
                                                        .format(snapshot
                                                            .data['total'])
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ));
                                        } else {
                                          return const Text('Empty data');
                                        }
                                      } else {
                                        return Text(
                                            'State: ${snapshot.connectionState}');
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        //last week
                        Column(
                          children: [
                            Expanded(
                                child: FutureBuilder<List<Sale>?>(
                              future: DatabaseHelper.getSales(
                                  _getStartDate(7), _getEndDate(0)),
                              builder: (context,
                                  AsyncSnapshot<List<Sale>?> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text(snapshot.error.toString()));
                                } else if (snapshot.hasData) {
                                  if (snapshot.data != null) {
                                    return ListView.builder(
                                      itemBuilder: (context, index) =>
                                          SalesWidget(
                                        sale: snapshot.data![index],
                                        onTap: () async {
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SaleDetailScreen(
                                                          sale: snapshot
                                                              .data![index])));
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
                            Card(
                              color: MyThemes.primary.shade300,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Text(
                                          'Тоо',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Text(
                                          'Нийт үнэ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  FutureBuilder<dynamic>(
                                    future: DatabaseHelper.getSaleStats(
                                        _getStartDate(7), _getEndDate(0)),
                                    builder: (
                                      BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot,
                                    ) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return const Text('Error');
                                        } else if (snapshot.hasData) {
                                          print(
                                              "___________________________________snapshot.data.toString()");
                                          print(snapshot.data.toString());
                                          // _getDetail(int.parse(snapshot.data['count']),double.parse(snapshot.data['total']));
                                          return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data['count']
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    NumberFormat.simpleCurrency(
                                                            name: "₮")
                                                        .format(snapshot
                                                            .data['total'])
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ));
                                        } else {
                                          return const Text('Empty data');
                                        }
                                      } else {
                                        return Text(
                                            'State: ${snapshot.connectionState}');
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        //last month
                        Column(
                          children: [
                            Expanded(
                                child: FutureBuilder<List<Sale>?>(
                              future: DatabaseHelper.getSales(
                                  _getStartDate(30), _getEndDate(0)),
                              builder: (context,
                                  AsyncSnapshot<List<Sale>?> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text(snapshot.error.toString()));
                                } else if (snapshot.hasData) {
                                  if (snapshot.data != null) {
                                    // _setCount(snapshot.data!.length);
                                    return ListView.builder(
                                      itemBuilder: (context, index) =>
                                          SalesWidget(
                                        sale: snapshot.data![index],
                                        onTap: () async {
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SaleDetailScreen(
                                                          sale: snapshot
                                                              .data![index])));
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
                            Card(
                              color: MyThemes.primary.shade300,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Text(
                                          'Тоо',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Text(
                                          'Нийт үнэ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  FutureBuilder<dynamic>(
                                    future: DatabaseHelper.getSaleStats(
                                        _getStartDate(30), _getEndDate(0)),
                                    builder: (
                                      BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot,
                                    ) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return const Text('Error');
                                        } else if (snapshot.hasData) {
                                          print(
                                              "___________________________________snapshot.data.toString()");
                                          print(snapshot.data.toString());
                                          // _getDetail(int.parse(snapshot.data['count']),double.parse(snapshot.data['total']));
                                          return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data['count']
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    NumberFormat.simpleCurrency(
                                                            name: "₮")
                                                        .format(snapshot
                                                            .data['total'])
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ));
                                        } else {
                                          return const Text('Empty data');
                                        }
                                      } else {
                                        return Text(
                                            'State: ${snapshot.connectionState}');
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    ));
  }
}
