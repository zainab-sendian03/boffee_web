import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hello/constants/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, bottom: 10),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Most Reading',
            style: TextStyle(
              color: dark_Brown,
              fontSize: 20,
            ),
          ),
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
                height: 190,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: medium_Brown,
                      offset: const Offset(0, 1),
                      blurRadius: 10,
                    )
                  ],
                  color: offwhite,
                ),
                child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: PageController(viewportFraction: 0.9),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, right: 8, left: 1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/web book.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Stack(
                            children: [
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'book_name',
                                      style: TextStyle(
                                        fontFamily: 'Inconsolata-Bold',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Author_name',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '2000',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/web book.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Stack(
                            children: [
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'book_name',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Author_name',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '2000',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])),
          )),
      Padding(
        padding: const EdgeInsets.only(left: 30, top: 30),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Most Rating',
            style: TextStyle(fontSize: 20, color: dark_Brown),
          ),
        ),
      ),
      Flexible(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 20),
                    child: Stack(
                      children: [
                        Container(
                          width: 350,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: offwhite,
                            boxShadow: [
                              BoxShadow(
                                color: medium_Brown,
                                offset: const Offset(0, 1),
                                blurRadius: 10,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 12),
                          //صورة
                          child: Row(
                            children: [
                              Container(
                                height: 160,
                                width: 125,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Light_Brown,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start, // إضافة هذه السطر لضبط المحاذاة
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Book_name',
                                        style: TextStyle(
                                          color: dark_Brown,
                                          fontSize: 19,
                                        )),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Text('Author_name',
                                        style: TextStyle(
                                          color: dark_Brown,
                                          fontSize: 19,
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RatingBarIndicator(
                                      rating: 2,
                                      unratedColor: Colors.amber.withAlpha(50),
                                      itemCount: 5,
                                      itemSize: 30.0,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }))
    ]);
  }
}
