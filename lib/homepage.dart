import 'dart:convert';

import 'package:day34/Model/modelclass.dart';
import 'package:day34/subpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String mylink =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR14-zBvr4aAilr0BzBX_fSQa1RotbkTHdrMCfKoQ7hLUuBC4JgtJD2exFY";

  List<Modelclass> mylist = [];
  late Modelclass object;

  Future dataFetch() async {
    var httpresponse = await http.get(Uri.parse(mylink));
    print(httpresponse.body);
    if (httpresponse.statusCode == 200) {
      var mydata = jsonDecode(httpresponse.body)['exercises'];
      for (var i in mydata) {
        object = Modelclass(
          id: i['id'],
          title: i['title'],
          thumbnail: i['thumbnail'],
          gif: i['gif'],
          seconds: i['seconds'],
        );
        setState(() {
          mylist.add(object);
        });
      }
    }
  }

  @override
  void initState() {
    dataFetch();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade100,
          elevation: 0,
          title: Text('List'),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: mylist.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext) => SubPage()));
                  print(mylist[index]);
                },
                child: Card(
                  color: index % 2 == 0
                      ? Colors.redAccent.shade100
                      : Colors.greenAccent.shade100,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "${mylist[index].id}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "${mylist[index].title}",
                        style: TextStyle(
                            color: index % 2 == 0 ? Colors.white : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    leading: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            NetworkImage("${mylist[index].thumbnail}")),
                  ),
                ),
              );
            })),
      ),
    );
  }
}
