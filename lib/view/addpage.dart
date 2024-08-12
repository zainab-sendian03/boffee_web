import 'package:flutter/material.dart';
import 'package:hello/core/Model/Detail_model.dart';
import 'package:hello/core/Model/category.dart';
import 'package:hello/core/Model/d_withFile.dart';
import 'package:hello/core/constants/color.dart';
import 'package:hello/core/constants/linksapi.dart';
import 'package:hello/core/service/get_type.dart';
import 'package:hello/core/service/service_category.dart';
import 'package:hello/view/Details.dart';
import 'package:hello/view/addBook.dart';

class allBooks extends StatefulWidget {
  const allBooks({super.key});

  @override
  _allBooksState createState() => _allBooksState();
}

class _allBooksState extends State<allBooks> {
  ValueNotifier<int> indexOfType = ValueNotifier(1);
  DetailModel? selectedBook;
  bool isDrawerOpen = false;

  void selectBook(DetailModel book) {
    setState(() {
      selectedBook = book;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      isDrawerOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: serviceUI().getAllCategories(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<CategoryModel> temp = snapshot.data as List<CategoryModel>;
                return DefaultTabController(
                  length: temp.length,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: TabBar(
                            dividerColor: no_color,
                            indicator: const BoxDecoration(),
                            indicatorWeight: 0,
                            onTap: (value) {
                              indexOfType.value = value + 1;
                            },
                            tabAlignment: TabAlignment.start,
                            indicatorColor: Colors.brown,
                            unselectedLabelColor: Colors.grey,
                            labelColor: Colors.brown,
                            isScrollable: true,
                            tabs: List.generate(
                              temp.length,
                              (index) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(color: Beege, width: 1.2),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 50),
                                child: Tab(
                                  child: Text(
                                    temp[index].name.toString(),
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ValueListenableBuilder(
                          valueListenable: indexOfType,
                          builder: (context, value, _) {
                            return Flexible(
                              child: FutureBuilder(
                                future:
                                    ServiceImmpl().getAllBook(value.toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<DetailModel> temp =
                                        snapshot.data as List<DetailModel>;
                                    return TabBarView(
                                      children: List.generate(
                                        6,
                                        (index) => GridView.builder(
                                          padding: const EdgeInsets.all(10),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 5,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                            childAspectRatio: 0.7,
                                          ),
                                          itemCount: temp.length,
                                          itemBuilder: (context, index) =>
                                              Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: 200,
                                                  height: 230,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: white,
                                                    border: Border.all(
                                                      color: medium_Brown,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Light_Brown,
                                                        offset:
                                                            const Offset(0, 1),
                                                        blurRadius: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 10,
                                                          top: 115,
                                                        ),
                                                        child: Text(
                                                          temp[index]
                                                              .title
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: dark_Brown,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Text(
                                                          temp[index]
                                                              .author_name
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: medium_Brown,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 45),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "coffee beans: ${temp[index].points}",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color:
                                                                    medium_Brown,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            Image.asset(
                                                              "assets/images/coin.png",
                                                              scale: 5,
                                                            ),
                                                            const SizedBox(
                                                                width: 4.0),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 6,
                                                    left: 10,
                                                    right: 10,
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      selectBook(temp[index]);
                                                      print(temp[index]);
                                                    },
                                                    child: Container(
                                                      height: 110,
                                                      width: 180,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            "$linkservername${temp[index].cover}",
                                                          ),
                                                          fit: BoxFit.fill,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Light_Brown,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                            );
                          },
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
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          if (isDrawerOpen && selectedBook != null)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  closeDrawer();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: medium_Brown,
                        offset: const Offset(0, 1),
                        blurRadius: 10,
                      ),
                    ],
                    color: offwhite,
                  ),
                  child: Stack(
                    children: [
                      BookDetailsPage(
                        color: offwhite,
                        width: MediaQuery.of(context).size.width * 0.5,
                        detail_File: Detail_withFile(file: selectedBook!),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          icon: Icon(
                            Icons.disabled_by_default_outlined,
                            color: medium_Brown,
                          ),
                          onPressed: closeDrawer,
                        ),
                      ),
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
