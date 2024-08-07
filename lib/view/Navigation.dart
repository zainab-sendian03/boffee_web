import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:hello/core/constants/color.dart';
import 'package:hello/view/addpage.dart';
import 'package:hello/view/auth/login.dart';
import 'package:hello/view/homepage.dart';
import 'package:hello/view/statistics.dart';

class SideMenue extends StatefulWidget {
  const SideMenue({
    super.key,
  });

  @override
  _SideMenueState createState() => _SideMenueState();
}

class _SideMenueState extends State<SideMenue> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Light_Brown,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              // showTooltip: false,
              displayMode: SideMenuDisplayMode.auto,
              // showHamburger: true,
              hoverColor: offwhite,
              selectedHoverColor: offwhite,
              selectedColor: offwhite,
              selectedTitleTextStyle: TextStyle(
                color: dark_Brown,
              ),
              selectedIconColor: dark_Brown,

              backgroundColor: Light_Brown,
            ),
            title: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset('assets/images/logo.png',
                          width: 40, height: 40),
                      const SizedBox(width: 15),
                      Text(
                        'Boffee',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inkfree',
                            color: dark_Brown),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 150,
                    maxWidth: 150,
                  ),
                ),
              ],
            ),
            items: [
              SideMenuItem(
                title: 'Home',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.home),
              ),
              SideMenuItem(
                title: 'Add',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.add),
              ),
              SideMenuItem(
                title: 'Statistics',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.bar_chart_outlined),
              ),
              SideMenuItem(
                builder: (context, displayMode) {
                  return Divider(
                    height: 380,
                    color: no_color,
                    endIndent: 8,
                    indent: 8,
                  );
                },
              ),
              SideMenuItem(
                onTap: (index, _) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                title: 'Exit',
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                  ),
                ),
                child: PageView(
                  controller: pageController,
                  children: [
                    const HomePage(),
                    CustomContainerTabs(),
                    Statistics(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
