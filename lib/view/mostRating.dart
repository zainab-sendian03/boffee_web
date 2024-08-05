import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hello/constants/color.dart';
import 'package:hello/constants/linksapi.dart';
import 'package:http/http.dart' as http;

class MostRating extends StatefulWidget {
  const MostRating({super.key});

  @override
  State<MostRating> createState() => _MostRatingState();
}

class _MostRatingState extends State<MostRating> {
  Future<Map<String, dynamic>> getMostRating() async {
    try {
      var response = await http.get(
        Uri.parse(link_mostRating),
      );
      print("Server response: ${response.body}");

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        if (responseBody is Map<String, dynamic> &&
            responseBody['success'] == true) {
          return responseBody;
        } else {
          return {
            'success': false,
            'message': 'Failed to fetch Most rating',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Failed to fetch Most rating',
        };
      }
    } catch (e) {
      print(e);
      return {
        'success': false,
        'message': 'An error occurred',
      };
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FutureBuilder(
        future: getMostRating(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: dark_Brown),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data?['success'] == true) {
            var data = snapshot.data?['data'];
            if (data is List) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = data[index];
                  String imageUrl = "$linkservername${item['cover']}";
                  print("Image URL: $imageUrl");

                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 15, bottom: 20, left: 30),
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
                          child: Row(
                            children: [
                              Container(
                                height: 160,
                                width: 125,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "http://localhost:8000/books/cover_images/book112.jpg")),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Light_Brown,
                                ),

                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(10),
                                //   child: Image.network(
                                //     "$linkservername${item['cover']}",
                                //     fit: BoxFit.fill,
                                //     errorBuilder: (context, error, stackTrace) {
                                //       return const Center(
                                //           child: Icon(Icons.error,
                                //               color: Colors.brown));
                                //     },
                                //     loadingBuilder: (context, child, progress) {
                                //       if (progress == null) {
                                //         return child;
                                //       } else {
                                //         return const Center(
                                //             child: CircularProgressIndicator());
                                //       }
                                //     },
                                //   ),
                                // ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Title: " + item['title'],
                                      style: TextStyle(
                                        color: dark_Brown,
                                        fontSize: 19,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 9),
                                    Text(
                                      "Author: " + item['author_name'],
                                      style: TextStyle(
                                        color: dark_Brown,
                                        fontSize: 19,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 10),
                                    RatingBarIndicator(
                                      rating: item['rate'].toDouble(),
                                      unratedColor: Colors.amber.withAlpha(50),
                                      itemCount: 5,
                                      itemSize: 23,
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
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          } else {
            return const Center(child: Text('Failed to fetch data'));
          }
        },
      ),
    );
  }
}
