import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int index;

  const CustomBottomNavBar({super.key, required this.index});

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0; // Default value

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index; // Update the index after the widget is initialized
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0) {
        Navigator.pushNamed(context, '/home');
      } else if (_selectedIndex == 1) {
        Navigator.pushNamed(context, '/kb');
      } else if (_selectedIndex == 2) {
        Navigator.pushNamed(context, '/faq');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Knowledge Base'),
        BottomNavigationBarItem(icon: Icon(Icons.question_answer), label: 'Q&A'),
      ],
      currentIndex: _selectedIndex,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
       unselectedItemColor: Colors.black,
      onTap: (index) => _onItemTapped(index),
    );
  }
}
