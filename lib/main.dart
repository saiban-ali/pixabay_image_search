import 'package:flutter/material.dart';
import 'package:image_search/SearchPage.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var myController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pixabay Image Search",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text("Search Me!!"),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 10.0),
              child: TextFormField(
                controller: myController,
                decoration: new InputDecoration(
                  labelText: "Enter a Keyword",
                  hintText: "e.g cats, dogs, cars etc...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                ),
              ),
            ),
            ListTile(
              title: RaisedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SearchPage(
                      keyword: myController.text,
                    );
                  }));
                },
                child: Text(
                  "Search",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                elevation: 5.0,
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                padding: EdgeInsets.all(15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
