import 'package:cryptoapp/pages/home_screen.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currIndx = 0;

  List<Widget> pages = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    double myheight = MediaQuery.of(context).size.height;
    double mywidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff454651),
        body: pages.elementAt(currIndx),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currIndx,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Color(0xff454651),
            type: BottomNavigationBarType.fixed,
            onTap: ((value) {
              setState(() {
                currIndx = value;
              });
            }),
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/1.1.png',
                    height: myheight * 0.03,
                    color: Colors.grey,
                  ),
                  label: '',
                  activeIcon: Image.asset(
                    'assets/icons/1.2.png',
                    height: myheight * 0.03,
                    color: Colors.white.withOpacity(0.7),
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/2.1.png',
                    height: myheight * 0.03,
                    color: Colors.grey,
                  ),
                  label: '',
                  activeIcon: Image.asset(
                    'assets/icons/2.2.png',
                    height: myheight * 0.03,
                    color: Colors.white.withOpacity(0.7),
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/3.1.png',
                    height: myheight * 0.03,
                    color: Colors.grey,
                  ),
                  label: '',
                  activeIcon: Image.asset(
                    'assets/icons/3.2.png',
                    height: myheight * 0.03,
                    color: Colors.white.withOpacity(0.7),
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/4.1.png',
                    height: myheight * 0.03,
                    color: Colors.grey,
                  ),
                  label: '',
                  activeIcon: Image.asset(
                    'assets/icons/4.2.png',
                    height: myheight * 0.03,
                    color: Colors.white.withOpacity(0.7),
                  )),
            ]),
      ),
    );
  }
}
