import 'package:flutter/material.dart';
import 'package:flutter_benchmark/benchmark1/calculation_tools.dart';

class CalculationBenchmark extends StatefulWidget {
  const CalculationBenchmark({super.key});

  @override
  State<CalculationBenchmark> createState() => _CalculationBenchmarkState();
}

class _CalculationBenchmarkState extends State<CalculationBenchmark> {
  final int calculateTimes = 10000;
  final ValueNotifier<double?> _calculationTime1 = ValueNotifier(null);
  final ValueNotifier<double?> _calculationTime2 = ValueNotifier(null);
  final ValueNotifier<double?> _calculationTime3 = ValueNotifier(null);
  final ValueNotifier<double?> _calculationTime4 = ValueNotifier(null);
  final ValueNotifier<double?> _calculationTime5 = ValueNotifier(null);
  final ValueNotifier<double?> _calculationTime6 = ValueNotifier(null);
  final ValueNotifier<double?> _calculationTime7 = ValueNotifier(null);
  final ValueNotifier<double?> _calculationTime8 = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _loop((sum, i) => sum += i, _calculationTime1);
    _loop((sum, i) => sum -= i, _calculationTime2);
    _loop((sum, i) => sum *= i, _calculationTime3);
    _loop((sum, i) => sum /= i, _calculationTime4);
    _calculate((int num) => fibonacci(num.toDouble()), _calculationTime5);
    _loop((sum, i) => DateTime.now().day.toDouble(), _calculationTime6);
    BinaryTree tree = _generateTree(calculateTimes, _calculationTime7);
    tree = _searchTree(tree, 7624, _calculationTime8);
  }

  @override
  void dispose() {
    _calculationTime1.dispose();
    _calculationTime2.dispose();
    _calculationTime3.dispose();
    _calculationTime4.dispose();
    _calculationTime5.dispose();
    _calculationTime6.dispose();
    super.dispose();
  }

  void _calculate(Function(int) callback, ValueNotifier<double?> targetValue) {
    DateTime startTime = DateTime.now();
    // Dart does not support tail recursion optimisation
    callback(50);
    DateTime endTime = DateTime.now();
    Duration duration = endTime.difference(startTime);
    targetValue.value = duration.inMicroseconds.toDouble();
  }

  void _loop(double Function(double, int) callback,
      ValueNotifier<double?> targetValue) {
    double sum = 0;
    DateTime startTime = DateTime.now();
    for (int i = 0; i < calculateTimes; i++) {
      sum = callback(sum, i);
    }
    DateTime endTime = DateTime.now();
    Duration duration = endTime.difference(startTime);
    targetValue.value = duration.inMicroseconds.toDouble();
  }

  BinaryTree _generateTree(int length, ValueNotifier<double?> targetValue) {
    BinaryTree tree = BinaryTree();
    DateTime startTime = DateTime.now();
    for (int i = 0; i < length; i++) {
      tree.insertValue(i);
    }
    DateTime endTime = DateTime.now();
    Duration duration = endTime.difference(startTime);
    targetValue.value = duration.inMicroseconds.toDouble();
    return tree;
  }

  BinaryTree _searchTree(
      BinaryTree tree, int value, ValueNotifier<double?> targetValue) {
    DateTime startTime = DateTime.now();
    tree.containsValue(value);
    DateTime endTime = DateTime.now();
    Duration duration = endTime.difference(startTime);
    targetValue.value = duration.inMicroseconds.toDouble();
    return tree;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Calculation')),
        body: Column(children: [
          ValueListenableBuilder(
              valueListenable: _calculationTime1,
              builder: (context, calculationTime1, child) {
                return Text('Add $calculateTimes times: $calculationTime1');
              }),
          ValueListenableBuilder(
              valueListenable: _calculationTime2,
              builder: (context, calculationTime2, child) {
                return Text('Minus $calculateTimes times: $calculationTime2');
              }),
          ValueListenableBuilder(
              valueListenable: _calculationTime3,
              builder: (context, calculationTime3, child) {
                return Text('Times $calculateTimes times: $calculationTime3');
              }),
          ValueListenableBuilder(
              valueListenable: _calculationTime4,
              builder: (context, calculationTime4, child) {
                return Text('Divide $calculateTimes times: $calculationTime4');
              }),
          ValueListenableBuilder(
              valueListenable: _calculationTime5,
              builder: (context, calculationTime5, child) {
                return Text('Fib 50 times: $calculationTime5');
              }),
          ValueListenableBuilder(
              valueListenable: _calculationTime6,
              builder: (context, calculationTime6, child) {
                return Text(
                    'Create instance of now $calculateTimes times: $calculationTime6');
              }),
          ValueListenableBuilder(
              valueListenable: _calculationTime7,
              builder: (context, calculationTime7, child) {
                return Text(
                    'Create binary tree with $calculateTimes nodes: $calculationTime7');
              }),
          ValueListenableBuilder(
              valueListenable: _calculationTime8,
              builder: (context, calculationTime8, child) {
                return Text(
                    'Search binary tree with at value 7624: $calculationTime8');
              }),
        ]));
  }
}
