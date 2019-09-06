import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchPage extends StatefulWidget {
  final String keyword;

  SearchPage({this.keyword});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List imageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Results",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: buildListView(),

//      body: FutureBuilder(
//        future: getImages(widget.keyword),
//        builder: (context, snapShot) {
//          Map images = snapShot.data;
//          if(snapShot.hasError) {
//            print(snapShot.error);
//            return Text(
//              "Unknown Error: Failed to retieve images from Pixabay",
//              style: TextStyle(color: Colors.red, fontSize: 24.0, fontWeight: FontWeight.bold),
//            );
//          } else if(snapShot.hasData) {
//            return Center(
//              child: ListView.builder(
//                  itemCount: images.length,
//                  itemBuilder: (context, index) {
//                    return Column(
//                      children: <Widget>[
//                        Padding(padding: EdgeInsets.all(5.0),),
//                        Container(
//                          child: InkWell(
//                            onTap: () {},
//                            child: Image.network("${images["hits"][index]["largeImageURL"]}"),
//                          ),
//                        )
//                      ],
//                    );
//                  },
//              ),
//            );
//          } else {
//            return Center(
//              child: CircularProgressIndicator(),
//            );
//          }
//        },
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text("Keyword Searched: ", style: TextStyle(fontSize: 24.0)),
//            Padding(padding: EdgeInsets.all(20.0),),
//            Text("\"" + widget.keyword + "\"", style: TextStyle(fontSize: 32.0, color: Colors.deepOrange),)
//          ],
//        ),
//      ),
    );
  }

  Future<String> getImages(String keyword) async {
    String url =
        "https://pixabay.com/api/?key=$apiKey&q=$keyword&image_type=photo&pretty=true";

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var itemCount = jsonResponse["totalHits"];
      setState(() {
        imageData = jsonResponse["hits"];
      });
      print("Number of images: $itemCount");
      List list = jsonResponse["hits"];
      print("Result Count: ${list.length}");
      return "Successful";
    } else {
      print("Request Failed with Status Code: ${response.statusCode}");
      return "Not Successful";
    }

//
//    this.setState(() {
//      data = json.decode(response.body);
//    });

//    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();

    this.getImages(widget.keyword);
  }

  Widget buildListView() => ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: imageData == null ? 0 : imageData.length,
        itemBuilder: (context, index) {
          return buildImageView(imageData[index]);
        },
      );

  Widget buildImageView(image) => Container(
        decoration: BoxDecoration(
          color: Colors.amber,
        ),
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: image["largeImageURL"],
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            ListTile(
              title: Text(image["user"]),
              subtitle: Text(image["tags"]),
            )
          ],
        ),
      );
}
