import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'pages/trace.dart';
import 'pages/map.dart';

Future main() async {
  await dotenv.load(fileName: "assets/.env");
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
        home: MainPage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  //   notifyListeners();
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  var _currentIndex = 0;
  final pageList = [MapPage(), TracePage()];
  final bottomNavigationBarList = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.map), label: ('地图')),
    BottomNavigationBarItem(icon: Icon(Icons.history), label: ('轨迹'))
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'play_map',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('play_map'),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: pageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (value) {
              setState(() {
                _currentIndex = value;
              });
              print("value = $value");
            },
            type: BottomNavigationBarType.fixed,
            items: bottomNavigationBarList,
            selectedItemColor: Colors.amber[800]),
      ),
    );
  }
}
