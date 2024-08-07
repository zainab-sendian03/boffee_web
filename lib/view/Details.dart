import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hello/core/Model/d_withFile.dart';
import 'package:hello/core/constants/color.dart';
import 'package:hello/core/constants/crud.dart';
import 'package:hello/core/constants/linksapi.dart';

// ignore: must_be_immutable
class BookDetailsPage extends StatefulWidget {
  BookDetailsPage(
      {super.key,
      required this.detail_File,
      required this.width,
      required this.color});
  final Detail_withFile detail_File;
  final double width;
  Color color;

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double avgRating = 0;
  bool isFirstTime = true;
  int MyPoints = 0;

  Future<dynamic> alert_report(
      BuildContext context, TextEditingController noteCont) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xFFFFF8F1),
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              height: MediaQuery.of(context).size.height * 0.2,
              child: TextFormField(
                showCursor: false,
                maxLines: 10,
                controller: noteCont,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "write your report....",
                    hintStyle: TextStyle(color: Color(0XFFA5A5A5))),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text("Send",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    )),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancle",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.brown,
                    )),
              ),
            ],
          );
        });
  }

  final Crud _crud = Crud();
  Future<void> get_AVG_rating() async {
    try {
      final bookId = widget.detail_File.file!.id;
      final url = "$link_AVGrating/$bookId";

      print("AVG Rating URL: $url");

      var response = await _crud.getrequest(url);
      print("Server response: $response");

      if (response is Map && response.containsKey('average_rating')) {
        setState(() {
          avgRating = double.parse(response['average_rating']);
        });
        print("Average rating fetched successfully");
      } else {
        print("Failed to fetch average rating");
        print("Server response: $response");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    get_AVG_rating();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: widget.width,
      child: Scaffold(
        body: Container(
          color: widget.color,
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Container(
                          height: 190,
                          width: 130,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: dark_Brown,
                                  offset: const Offset(0, 1),
                                  blurRadius: 10,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    "http://localhost:8000${widget.detail_File.file!.cover}",
                                  ),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            widget.detail_File.file!.title.toString(),
                            style: const TextStyle(
                                letterSpacing: 1,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        RatingBarIndicator(
                          rating: avgRating,
                          unratedColor: Colors.amber.withAlpha(50),
                          itemCount: 5,
                          itemSize: 30.0,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star_border,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          "Author: ${widget.detail_File.file!.author_name}",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: dark_Brown,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Pages: ${widget.detail_File.file!.total_pages}",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: dark_Brown,
                              ),
                            ),
                            const SizedBox(width: 50),
                            Text(
                              "coffee beans: ${widget.detail_File.file!.points}",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: dark_Brown,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Image.asset(
                              "assets/images/coin.png",
                              scale: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 28,
                          left: 290,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: dark_Brown,
                          ),
                          onPressed: () {},
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TabBar(
                        tabAlignment: TabAlignment.start,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: dark_Brown,
                        unselectedLabelColor: Colors.grey,
                        labelColor: dark_Brown,
                        isScrollable: true,
                        controller: _tabController,
                        tabs: const [
                          Tab(
                            child: Text(
                              'Info',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Reviews',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 135, left: 25, right: 25),
                            child: Center(
                                child: Text(
                              widget.detail_File.file!.description.toString(),
                              style: const TextStyle(fontSize: 20),
                            )),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          ListView(
                            scrollDirection: Axis.vertical,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 30),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: offwhite,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Light_Brown,
                                          offset: const Offset(0, 5),
                                          blurRadius: 10,
                                          // spreadRadius: 10,
                                        )
                                      ]),
                                  height: 140,
                                  width: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
