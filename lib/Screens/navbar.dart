import 'package:flutter/material.dart';

import '../Constants/constants.dart';
import 'favorite.dart';
import 'homescreen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  List<List<Color>> _pageColors = List.generate(
    3,
    (index) => List.filled(4, Colors.green),
  );

  void _changeIconColor(int iconIndex) {
    setState(() {
      // Reset the color of the previous selected icon
      _pageColors[_selectedIndex].fillRange(0, 5, Colors.green);

      // Set the color of the selected icon to white
      _pageColors[_selectedIndex][iconIndex] = Colors.white;
    });
  }

  void _changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage;
    switch (_selectedIndex) {
      case 0:
        currentPage = HomeScreen();
        break;
      case 1:
        currentPage = SearchBar();
        break;
      case 2:
        currentPage = Favorite();
        break;
      default:
        currentPage = HomeScreen();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          currentPage,
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
                left: 50.0,
                right: 50.0,
                top: 10.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: primary,
                  border: Border.all(
                      color: Color.fromARGB(255, 0, 0, 0), width: 3.0),
                ),
                width: 70,
                height: 65.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(3, (pageIndex) {
                    // Custom icons for each page
                    IconData customIcon;
                    Color iconColor;
                    switch (pageIndex) {
                      case 0:
                        customIcon = Icons.home;
                        break;
                      case 1:
                        customIcon = Icons.search;
                        break;
                      case 2:
                        customIcon = Icons.person;
                        break;
                      default:
                        customIcon = Icons.star;
                    }

                    // Set the color of the unselected icon
                    iconColor = _selectedIndex == pageIndex
                        ? const Color.fromARGB(255, 0, 0, 0)
                        : const Color.fromARGB(255, 255, 255, 255);

                    return GestureDetector(
                      onTap: () => _changePage(pageIndex),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: _selectedIndex == pageIndex
                              ? Colors.yellow
                              : primary,
                          border: Border.all(
                            color: _selectedIndex == pageIndex
                                ? Color.fromARGB(255, 0, 0, 0)
                                : Colors.transparent,
                            width: 3.0,
                          ),
                        ),
                        width: 55.0,
                        height: 45.0,
                        child: Icon(
                          customIcon,
                          color: iconColor,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
