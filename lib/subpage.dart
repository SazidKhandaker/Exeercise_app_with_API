import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:day34/Model/modelclass.dart';
import 'package:day34/singleditelsepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class SubPage extends StatefulWidget {
  SubPage({
    super.key,
  });

  @override
  State<SubPage> createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
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
            title: Text("Your Exercises List"),
            centerTitle: true,
          ),
          body: ListView.builder(
              itemCount: mylist.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SinglePage(
                                    mdl: mylist[index],
                                  )));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      child: Stack(children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: "${mylist[index].thumbnail}",
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment(0.0, 1.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(colors: [
                                  Colors.black54,
                                  Colors.black87,
                                  Colors.transparent,
                                ])),
                            child: Center(
                                child: Text(
                              "${mylist[index].title}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              })),
    );
  }
}
