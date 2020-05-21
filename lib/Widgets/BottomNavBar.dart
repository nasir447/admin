import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  
  int _selectedIndex = 0;
  final List<String> _pageOptions = [
    '/home',
    '/update',
    '/order', 
    '/rider'
  ];

  @override
  Widget build(BuildContext context) {
    

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (value){
        _selectedIndex = value;
        setState(() {
          Navigator.pushReplacementNamed(context, _pageOptions[_selectedIndex]);
        });  
      },
      selectedItemColor: Colors.blue,
      selectedFontSize: 22.0,
      unselectedFontSize: 18.0,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(
            'Home',
            style: TextStyle(color: Colors.black),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.update),
          title: Text(
            'Update',
            style: TextStyle(color: Colors.black),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_shopping_cart),
          title: Text(
            'Orders',
            style: TextStyle(color: Colors.black),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.biking),
          title: Text(
            'Rider',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );    
  }
}
