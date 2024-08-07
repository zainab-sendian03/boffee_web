import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:hello/core/config/options.dart';
import 'package:hello/core/constants/color.dart';
import 'package:hello/core/service/logout.dart';
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

  Future<dynamic> alert(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SizedBox(
            height: 300,
            width: 350,
            child: AlertDialog(
              backgroundColor: Color(0xFFFFF8F1),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              icon: const Icon(
                Icons.error,
                size: 50,
                color: Color(0xFF94745B),
              ),
              content: const Text(
                "Are you sure you want to log out?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              actions: <Widget>[
                Center(
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          logout();
                          pref!.clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: medium_Brown,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 15, bottom: 15)),
                        child: const Text("LogOut",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: no_color,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: medium_Brown),
                                borderRadius: BorderRadius.circular(25)),
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 15, bottom: 15)),
                        child: Text("Cancel",
                            style: TextStyle(
                              fontSize: 14,
                              color: medium_Brown,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
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
                  alert(context);
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
                  children: const [
                    HomePage(),
                    allBooks(),
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
