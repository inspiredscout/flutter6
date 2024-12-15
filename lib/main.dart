import 'package:flutter/material.dart';
import 'package:practice_6/model/collector.dart';
import 'package:practice_6/pages/home_page.dart';
import 'package:practice_6/pages/second_page.dart';
import 'package:practice_6/pages/third_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Collector> _favouriteCollector = [];

  void _toggleFavourite(Collector coffee) {
    setState(() {
      if (_favouriteCollector.contains(coffee)){
        _favouriteCollector.remove(coffee);
      } else {
        _favouriteCollector.add(coffee);
      }
    });
  }
void _addToCart(Collector collector) {
    print('Добавлено в корзину: ${collector.title}');
}
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomePage(
        onFavouriteToggle: _toggleFavourite,
        favouriteCollector: _favouriteCollector,
      ),
      SecondPage(
        favouriteCollector: _favouriteCollector,
        onFavouriteToggle: _toggleFavourite,
        onAddToCart: _addToCart,
      ),
      const ThirdPage(),
    ];
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
