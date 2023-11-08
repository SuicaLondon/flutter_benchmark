import 'package:flutter/material.dart';
import 'package:flutter_benchmark/benchmark1/calculation_benchmark.dart';
import 'package:flutter_benchmark/benchmark2/complex_ui_benchmark.dart';

enum BenchmarkItem {
  calculation('Calculation benchmark', CalculationBenchmark()),
  complexUI('Complex UI Render benchmark', ComplexUIBenchMark());

  const BenchmarkItem(this.name, this.page);
  final String name;
  final Widget page;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void Function() _changePage(BuildContext context, BenchmarkItem item) {
    return () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return item.page;
        },
      ));
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Builder(builder: (context) {
            return Column(
                children: BenchmarkItem.values.map((item) {
              return TextButton(
                  onPressed: _changePage(context, item),
                  child: Text(item.name));
            }).toList());
          }),
        ),
      ),
    );
  }
}
