import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_benchmark/benchmark3/random_animation_builder.dart';

class ComplexAnimationBenchMark extends StatefulWidget {
  const ComplexAnimationBenchMark({super.key});

  @override
  State<ComplexAnimationBenchMark> createState() =>
      _ComplexAnimationBenchMarkState();
}

class _ComplexAnimationBenchMarkState extends State<ComplexAnimationBenchMark> {
  final ValueNotifier<int?> _firstFrameRenderTime = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    DateTime startTime = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DateTime endTime = DateTime.now();
      Duration duration = endTime.difference(startTime);
      _firstFrameRenderTime.value = duration.inMilliseconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex Animation BenchMark'),
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: _firstFrameRenderTime,
            builder: (context, firstFrameRenderTime, child) {
              return Text('First frame render time: $firstFrameRenderTime');
            },
          ),
          Expanded(
            child: Stack(
              children: List.generate(
                1000,
                (index) {
                  double ratio = Random().nextDouble();
                  return RandomAnimationWidget(
                    left: MediaQuery.of(context).size.width * ratio,
                    top: MediaQuery.of(context).size.height * ratio,
                    type: AnimationType.byNumber(index),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.red,
                          Colors.green,
                        ]),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.yellow, offset: Offset(1, 0)),
                          BoxShadow(color: Colors.blue, offset: Offset(1, 0)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
