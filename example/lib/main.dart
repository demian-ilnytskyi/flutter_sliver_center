import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliver_center/sliver_center.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sliver Center Example',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverLayoutBuilder(
            builder: (context, constraints) => SliverConstrainedCrossAxis(
              maxExtent: constraints.crossAxisExtent * 0.5,
              sliver: SliverCenter(
                sliver: SliverList.builder(
                  itemBuilder: (context, index) {
                    final color = index % 2 == 0 ? Colors.red : Colors.blue;
                    return Container(
                      height: 100,
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        bottom: 10,
                      ),
                      color: color,
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
