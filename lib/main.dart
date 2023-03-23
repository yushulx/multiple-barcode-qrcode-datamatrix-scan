import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'scanner_screen.dart';
import 'settings_screen.dart';
import 'switch_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => SwitchProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _types = 0;
  void _launchCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ScannerScreen(
                types: _types,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              var result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
              _types = result['format'];
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _launchCamera,
        tooltip: 'Barcode Scanner',
        child: const Icon(Icons.camera),
      ),
    );
  }
}
