import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/first_flutter_app.dart';
import 'pages/trace.dart';
import 'pages/map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
          title: 'Namer App',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          ),
          home: MainPage()),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_currentIndex) {
      case 0:
        page = MapPage();
        break;
      case 1:
        page = TracePage();
        break;
      case 2:
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('no widget for $_currentIndex');
    }

    return MaterialApp(
      title: 'play_map',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('play_map'),
        ),
        body: page,
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (value) {
              setState(() {
                _currentIndex = value;
              });
              print("value = $value");
            },
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.map), label: ('地图')),
              BottomNavigationBarItem(icon: Icon(Icons.history), label: ('轨迹')),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.person_outline), label: ('我')),
            ],
            selectedItemColor: Colors.amber[800]),
      ),
    );
  }
}
