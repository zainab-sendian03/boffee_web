import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:hello/constants/color.dart';

class CustomFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: medium_Brown,
      borderType: BorderType.RRect,
      dashPattern: [6, 3],
      strokeWidth: 3,
      radius: Radius.circular(12),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: Beige,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 32.0,
            ),
          ),
        ),
      ),
    );
  }
}

//   late TabController _tabController;

// Future<dynamic> alert_report(
//       BuildContext context, TextEditingController noteCont) {
//     return showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: const Color(0xFFFFF8F1),
//             elevation: 0,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//             content: SizedBox(
//               width: MediaQuery.of(context).size.width * 0.65,
//               height: MediaQuery.of(context).size.height * 0.2,
//               child: TextFormField(
//                 showCursor: false,
//                 maxLines: 10,
//                 controller: noteCont,
//                 decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     hintText: "write your report....",
//                     hintStyle: TextStyle(color: Color(0XFFA5A5A5))),
//               ),
//             ),);
//             });
//       }

class CustomContainerTabs extends StatefulWidget {
  @override
  _CustomContainerTabsState createState() => _CustomContainerTabsState();
}

class _CustomContainerTabsState extends State<CustomContainerTabs> {
  int _selectedIndex = 0;

  final List<String> _tabTitles = [
    'Novel',
    'Islamic',
    'Kids',
    'Human Development',
    'Horror',
    'Science',
  ];

  final List<Widget> _tabContents = [
    GridViewExample(),
    Center(child: Text(' Islamic')),
    Center(child: Text(' Kids')),
    Center(child: Text(' Human')),
    Center(child: Text(' Horror')),
    Center(child: Text(' Science')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_tabTitles.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index; // تحديث التاب المحدد
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedIndex == index ? Beege : white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Beege, width: 2),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                    child: Center(
                      child: Text(
                        _tabTitles[index],
                        style: TextStyle(
                          fontSize: 17,
                          color: _selectedIndex == index ? white : dark_Brown,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            Expanded(
              child: _tabContents[_selectedIndex],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50, bottom: 40),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: CustomFloatingActionButton()),
            ),
          ],
        ),
      ),
    );
  }
}

class GridViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 1,
        mainAxisSpacing: 4,
      ),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 40,
            left: 50,
          ),
          child: GestureDetector(
            onTap: () {
              // alert_report(context,TextEditingController());
            },
            child: Stack(
              children: [
                Container(
                  width: 200,
                  height: 190,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: white,
                    // border: Border.all(
                    //    color: medium_Brown,
                    //  ),
                    boxShadow: [
                      BoxShadow(
                        color: Beige,
                        offset: const Offset(0, 1),
                        blurRadius: 10,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 15, right: 10),
                  child: Container(
                    height: 110,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Light_Brown,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
