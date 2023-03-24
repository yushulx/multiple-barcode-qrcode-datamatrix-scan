import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  final String title;
  const InfoView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Stack(
        children: const [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'With Dynamsoft Barcode Reader SDK, developers can easily transform mobile phones and tablets into enterprise-grade barcode scanning and data capture tools.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
