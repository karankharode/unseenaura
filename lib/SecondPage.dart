import 'package:flutter/material.dart';
import 'package:unseenaura/ListBuilder.dart';
import 'package:unseenaura/config.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
            //       //Heading Code
            Padding(
              padding: const EdgeInsets.only(top: 35.0, left: 10, right: 10,bottom: 5),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: tileColor,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Image(
                              image: AssetImage("assets/arrow.png"),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left:1.0,right: 1),
                            child: new Container(
                              width: MediaQuery.of(context).size.width - 80,
                              child: new Text(
                                "${pageNames[pageIndex]['name']} | Unseen Aura : Dark Web & Darknet",
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 1,
                                style:
                                    TextStyle(fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                     color: textColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          
          //   List 
            Listbuilder()
          ])),
    );
  }
}
