import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:day34/Model/modelclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyWidget extends StatefulWidget {
  MyWidget({super.key, this.mdl, this.second});
  Modelclass? mdl;
  int? second;
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Timer? timer;
  int startcount = 0;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == widget.second) {
        timer.cancel();
      }
      setState(() {
        startcount = timer.tick;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          CachedNetworkImage(
            height: MediaQuery.of(context).size.height * 0.6,
            fit: BoxFit.cover,
            imageUrl: "${widget.mdl!.gif}",
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.001,
            left: MediaQuery.of(context).size.width * 0.45,
            child: Text(
              (widget.second) == startcount
                  ? '$startcount s Workout done'
                  : '${startcount} S',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
          ),
        ]),
      ),
    );
  }
}
