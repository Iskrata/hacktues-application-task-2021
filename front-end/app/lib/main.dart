import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

createCard(String title, String description, userId) async {
  await http.post(
    Uri.parse('http://localhost:3000/${userId}/cards'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': title,
      'description': description,
    }),
  );
  return 1;
}

Future<List> fetchCards() async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/user/cards'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body));
  } else {
    throw Exception('Failed to load cards');
  }
}

Future<List> fetchUsers() async {
  final response = await http.get(Uri.parse('http://localhost:3000/'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body));
  } else {
    throw Exception('Failed to load cards');
  }
}

class Card {
  final String name;
  final String description;
  final String author;

  Card({required this.description, required this.name, required this.author});

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      name: json['name'],
      description: json['description'],
      author: json['author'],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   super.initState();
  //   _futureCards = fetchCards();
  // }

  @override
  Widget build(BuildContext context) {
    var _futureCards = fetchCards();

    return MaterialApp(
      title: 'app',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Database'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          //child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
          //child: homePage(),
          child: FutureBuilder(
            future: _futureCards,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return homePage(context, snapshot.data);
                //return Text(snapshot.data.toString());
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Widget cardDisplay(object) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: object == null ? 0 : object.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(object[index]["_id"]),
            Text(object[index]["name"]),
            Text(object[index]["author"]),
            Text(object[index]["description"]),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      http.delete(
                        Uri.parse(
                            'http://localhost:3000/cards/${object[index]["_id"]}'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                      );
                    });
                  },
                  child: Text("Delete"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Update"),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Widget homePage(context, object) {
    var title;
    var author;
    var description;

    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Builder(
                  builder: (conetxt) => ElevatedButton(
                    //onPressed: () => Navigator.pushNamed(context, '/add'),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title: Text('New card form'),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Title',
                                      icon: Icon(Icons.message),
                                    ),
                                    onChanged: (value) {
                                      title = value;
                                    },
                                  ),
                                  DropdownButton(
                                    hint: Row(children: [
                                      Icon(
                                        Icons.account_box,
                                        color: Colors.grey,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 0, 0, 0),
                                        child: Text("Select author"),
                                      ),
                                    ]),
                                    items: <String>[
                                      '60ddc08762519c55cc6c15f8',
                                      '60ddd5575ebcfc20e0970a9f'
                                    ].map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        author = value;
                                      });
                                    },
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Description',
                                      icon: Icon(Icons.email),
                                    ),
                                    onChanged: (value) {
                                      description = value;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  setState(() {
                                    createCard(title, description, author);
                                    Navigator.pop(context, 'OK');
                                  });
                                })
                          ],
                        );
                      },
                    ),
                    child: Text("Add card"),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
              //width: MaxColumnWidth,
              height: 400,
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Id"),
                          Text("Title"),
                          Text("Author"),
                          Text("Description"),
                          Text("Actions"),
                        ],
                      ),
                    ),
                  ),
                  cardDisplay(object),
                  // Row(
                  //   children: [
                  //     Text("Roses & Swords"),
                  //     Text("Roses & Swords"),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//   Column buildColumn() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         TextField(
//           controller: _controller,
//           decoration: InputDecoration(hintText: 'Enter Title'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               _futureCard = createCard(_controller.text);
//             });
//           },
//           child: Text('Create Data'),
//         ),
//       ],
//     );
//   }

//   FutureBuilder<Card> buildFutureBuilder() {
//     return FutureBuilder<Card>(
//       future: _futureCard,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Text(snapshot.data!.name);
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }

//         return CircularProgressIndicator();
//       },
//     );
//   }
}
