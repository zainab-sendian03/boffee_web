import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hello/core/Model/d_withFile.dart';
import 'package:hello/core/constants/color.dart';
import 'package:hello/core/constants/crud.dart';
import 'package:hello/core/constants/linksapi.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({super.key, required this.detail_File});
  final Detail_withFile detail_File;

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

//,required this.detailModel
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: medium_Brown,
        title: Text(
          'Book Details',
          style: TextStyle(color: dark_Brown),
        ),
        actions: [
          IconButton(
            color: white,
            icon: const Icon(Icons.favorite_outline),
            onPressed: () {
              // اضف هنا الاكشن الذي تريده عند الضغط على أيقونة المفضلة
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: dark_Brown,
            size: 35,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // صورة الكتاب
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10, top: 28),
                child: Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            "http://localhost:8000${widget.detail_File.file!.cover}",
                          ),
                          fit: BoxFit.fill)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.detail_File.file!.title.toString(),
                      style: const TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      widget.detail_File.file!.author_name.toString(),
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      widget.detail_File.file!.total_pages.toString(),
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'type',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 10.0),
                    RatingBarIndicator(
                      rating: avgRating,
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
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: TabBar(
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.brown,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.brown,
              isScrollable: true,
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text(
                    'Info',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Center(
                  widthFactor: 2,
                  child: Tab(
                    child: Text(
                      'Reviews',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 70, top: 300, left: 20),
                              child: SizedBox(
                                width: 130,
                                height: 50,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.brown),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'Read now',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: white,
                                    ),
                                  ),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                top: 300,
                                right: 20,
                                bottom: 70,
                              ),
                              child: SizedBox(
                                width: 130,
                                height: 50,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            no_color),
                                    elevation: MaterialStateProperty.all(0),
                                    side: MaterialStateProperty.all(
                                        const BorderSide(color: Colors.brown)),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'Read Later',
                                    style: TextStyle(
                                      fontSize: 16.8,
                                      color: medium_Brown,
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        alert_report(context, TextEditingController());
                      },
                      child: const Text(
                        'Report',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
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
    );
  }
}
