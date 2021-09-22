import 'package:flutter/material.dart';
import '../app_data.dart';

import './pages/advanced_page.dart';
import './pages/simple_page.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {


  /// Map that contains page and the title for each page
  final List<Map<String, dynamic>> _pagesData = [
    {'page': SimplePage(), 'title': 'מחשבון מהיר'},
    {'page': AdvancedPage(), 'title': 'מחשבון מתקדם'},
  ];

  /// The index of which determine what page is selected
  int _selectedIndex = 0;

  /// The right background based on device's screen ratio
  String get _backgroundImageName{
    final double aspectRatio = MediaQuery.of(context).size.aspectRatio;
    if ( aspectRatio > 0.5)
      return "images/wide-background.png";
    else
       return "images/background.png";
  }

  /// Sets the page
  _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // set that background wont jump when keyboard appears
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(APP_DATA.APPBAR_HEIGHT),
        child: AppBar(
          title: FittedBox(
            child: Text(
              _pagesData[_selectedIndex]['title'],
            ),
          ),
        ),
      ),
      drawer: MainDrawer(),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - APP_DATA.APPBAR_HEIGHT,
        // width & height are set as minimum. just in case :)
        child: _pagesData[_selectedIndex]['page'],
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_backgroundImageName),
            fit: BoxFit.cover,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedIndex,
        backgroundColor: Theme.of(context).accentColor,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        items: [
          const BottomNavigationBarItem(
            icon: const Icon(Icons.category),
            title: const Text(
              'מהיר',
              style: const TextStyle(fontSize: 20, fontFamily: 'MiriamLibre'),
            ),
          ),
          const BottomNavigationBarItem(
            icon: const Icon(Icons.tune),
            title: const Text(
              'מתקדם',
              style: const TextStyle(fontSize: 20, fontFamily: 'MiriamLibre'),
            ),
          )
        ],
      ),
    );
  }
}
