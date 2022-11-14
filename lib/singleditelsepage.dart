import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:day34/Model/modelclass.dart';
import 'package:day34/shownpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SinglePage extends StatefulWidget {
  SinglePage({super.key, this.mdl});
  Modelclass? mdl;

  @override
  State<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
  Timer? timer;
  var sound = 3;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          color: Colors.black,
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: double.infinity,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: NetworkImage(
                //           '${widget.mdl!.thumbnail}',
                //         ),
                //         fit: BoxFit.cover)),

                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: "${widget.mdl!.thumbnail}",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: MediaQuery.of(context).size.width * 0.3,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SleekCircularSlider(
                      min: 0,
                      max: 30,
                      initialValue: sound.toDouble(),
                      onChange: (double value) {
                        setState(() {
                          sound = value.toInt();
                        });
                      },
                      onChangeStart: (double startValue) {
                        // callback providing a starting value (when a pan gesture starts)
                      },
                      onChangeEnd: (double endValue) {
                        // ucallback providing an ending value (when a pan gesture ends)
                      },
                      innerWidget: (double value) {
                        return Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${sound}",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      child: MaterialButton(
                        color: Colors.redAccent.shade100,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyWidget(
                                mdl: widget.mdl,
                                second: sound,
                              ),
                            ),
                          );
                          print(sound);
                        },
                        child: Center(child: Text("Click")),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
