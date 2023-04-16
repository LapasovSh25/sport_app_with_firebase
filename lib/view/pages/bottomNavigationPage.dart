import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sport_app_with_api/view/pages/history_page.dart';
import 'package:sport_app_with_api/view/pages/profile_page.dart';
import 'package:sport_app_with_api/view/pages/store_page.dart';

import 'home_page.dart';

class PageBottomNavigation extends StatefulWidget {
  const PageBottomNavigation({super.key});

  @override
  State<PageBottomNavigation> createState() => _PageBottomNavigationState();
}

Stream<QuerySnapshot> historyStream = FirebaseFirestore.instance
    .collection("history")
    .orderBy("created_at")
    .snapshots();

class _PageBottomNavigationState extends State<PageBottomNavigation> {
  final List<Widget> _screens = [
    const HomePage(),
    HistoryPage(stream: historyStream),
    const StorePage(),
    const ProfilePage()
  ];
  int _correntIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(47, 60, 80, 1),
      body: Stack(
        children: [
          _screens.elementAt(_correntIndex),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Align(
              alignment: const Alignment(0.0, 1.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                child: BottomNavigationBar(
                  backgroundColor: const Color.fromRGBO(47, 60, 80, 1),
                  selectedItemColor: const Color.fromRGBO(241, 73, 133, 1),
                  unselectedItemColor: Colors.grey,
                  // showSelectedLabels: true,
                  // showUnselectedLabels: false,
                  // backgroundColor: Colors.black,
                  currentIndex: _correntIndex,
                  onTap: (int index) {
                    setState(() {
                      _correntIndex = index;
                    });
                  },
                  // ignore: prefer_const_literals_to_create_immutables
                  items: [
                    const BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/homeIcon.png'),
                        size: 35,
                      ),
                      label: "",
                    ),
                    const BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/cup.png'),
                        size: 35,
                      ),
                      label: "",
                    ),
                    const BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/shopping-bag.png'),
                        size: 35,
                      ),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/user.png'),
                        size: 35,
                      ),
                      label: "",
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
