import 'package:dynamsoft_capture_vision_flutter/dynamsoft_capture_vision_flutter.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  Map<String, BarcodeResult> results = {};

  ResultScreen({Key? key, required this.results}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text('Scan Results'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'))
          ],
        ),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: widget.results.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '${index}: ${widget.results.values.elementAt(index).barcodeText}'),
                    subtitle: Text(widget.results.values
                        .elementAt(index)
                        .barcodeFormatString),
                  );
                }),
            Positioned(
                bottom: 50,
                left: 50,
                right: 50,
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('SCAN AGAIN'),
                  ),
                ))
          ],
        ));
  }
}
