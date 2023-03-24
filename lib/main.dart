import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'about_view.dart';
import 'history_view.dart';
import 'home_view.dart';
import 'scan_provider.dart';
import 'switch_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => SwitchProvider()),
    ChangeNotifierProvider(create: (_) => ScanProvider()),
  ], child: const MyApp()));
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: const [
          HomeView(title: 'Dynamsoft Barcode SDK'),
          HistoryView(title: 'History'),
          InfoView(title: 'About the SDK'),
        ],
      ),
      bottomNavigationBar: TabBar(
        labelColor: Colors.blue,
        controller: _tabController,
        tabs: const [
          Tab(icon: Icon(Icons.home), text: 'Home'),
          Tab(icon: Icon(Icons.history_sharp), text: 'History'),
          Tab(icon: Icon(Icons.info), text: 'About'),
        ],
      ),
    );
  }
}
