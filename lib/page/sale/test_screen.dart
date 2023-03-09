import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:profile/model/sale_model.dart';

import '../../themes.dart';

class TestScreen extends StatefulWidget {
  final Sale? sale;

  const TestScreen({Key? key, this.sale}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool play = false;

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TEST'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: 200,
            height: 350,
            child: Stack(
              children: <Widget>[
                AnimatedPositioned(
                  width: play ? 200.0 : 50.0,
                  height: play ? 150.0 : 200.0,
                  top: play ? 50.0 : 150.0,
                  duration: const Duration(seconds: 5),
                  curve: Curves.fastOutSlowIn,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        play = !play;
                      });
                    },
                  ),
                ),
                Stack(
                  children: <Widget>[
                    AnimatedPositioned(
                      width: play ? 200.0 : 50.0,
                      height: play ? 50.0 : 200.0,
                      top: play ? 50.0 : 150.0,
                      duration: const Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn,
                      child: Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.green,
                          child: const Center(
                            child: Text("GREEN"),
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 200),
                      height: play ? 200 : 0,
                      width: play ? MediaQuery.of(context).size.height / 2 : 0,
                      left: 0,
                      bottom: play ? MediaQuery.of(context).size.height / 2 : 0,
                      child: Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.blue,
                          child: const Center(
                            child: Text("BLUE"),
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 1200),
                      child: Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.purple,
                          child: const Center(
                            child: Text("PURPLE"),
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      curve: Curves.slowMiddle,
                      duration: const Duration(milliseconds: 2000),
                      // height: play ? 100 : 0,
                      // left: 0,
                      // right: 0,
                      // bottom:
                      child: Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.red,
                          child: const Center(
                            child: Text(
                              "STACK",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyThemes.primary,
          onPressed: () async {
            setState(() {
              play = !play;
            });
          },
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
