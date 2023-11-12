import 'package:flutter/material.dart';

class ComplexUIBenchMark extends StatefulWidget {
  const ComplexUIBenchMark({super.key});

  @override
  State<ComplexUIBenchMark> createState() => _ComplexUIBenchMarkState();
}

class _ComplexUIBenchMarkState extends State<ComplexUIBenchMark> {
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
        title: const Text('Complex UI BenchMark'),
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: _firstFrameRenderTime,
            builder: (context, firstFrameRenderTime, child) {
              return Text('First frame render time: $firstFrameRenderTime');
            },
          ),
          SizedBox(
            height: 350,
            child: Stack(
              children: List.generate(
                1000,
                (index) => Container(
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
