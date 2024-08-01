// import 'package:flutter/material.dart';
// import 'package:hello/core/color.dart';

// class BookDetailsPage extends StatefulWidget {
//   const BookDetailsPage({super.key});

//   @override
//   State<BookDetailsPage> createState() => _BookDetailsPageState();
// }

// class _BookDetailsPageState extends State<BookDetailsPage>
//     with SingleTickerProviderStateMixin {


  
//   @override
//   Widget build(BuildContext context) {
//     var _tabController;
//     return Scaffold
//     (
      

    
 
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 10, top: 28),
//                 child: Container(
//                   height: 200,
//                   width: 150,
//                   color: Colors.blue,
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only( top: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       'Book Title',
//                       style: TextStyle(
//                           fontSize: 24.0, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 10.0),
//                     Text(
//                       'Author: Author Name',
//                       style: TextStyle(fontSize: 18.0),
//                     ),
//                     SizedBox(height: 10.0),
//                     Text(
//                       'Pages: 300',
//                       style: TextStyle(fontSize: 18.0),
//                     ),
                  
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 25),
//             child: TabBar(
//               tabAlignment: TabAlignment.start,
//               indicatorSize: TabBarIndicatorSize.label,
//               indicatorColor: Colors.brown,
//               unselectedLabelColor: Colors.grey,
//               labelColor: Colors.brown,
//               isScrollable: true,
//               controller: _tabController,
//               tabs: const [
//                 Tab(
//                   child: Text(
//                     'Info',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//                 Center(
//                   widthFactor: 2,
//                   child: Tab(
//                     child: Text(
//                       'Reviews',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 Stack(
//                   children: [
//                     const Center(child: Text('Content of Tab 1')),
                  
//                   ],
//                 ),
//                 Stack(
//                   children: [
//                     ListView(
//                       scrollDirection: Axis.vertical,
//                       children: <Widget>[
//                         Padding(
//                           padding:
//                               const EdgeInsets.only(left: 30, right: 30, top: 30),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Light_Brown,
//                                     offset: const Offset(0, 5),
//                                     blurRadius: 10,
//                                     // spreadRadius: 10,
//                                   )
//                                 ]),
//                             height: 140,
//                             width: 20,
//                           ),
//                         ),
//                       ],
//                     ),
                  
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
