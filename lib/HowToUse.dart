import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import 'config.dart';

class HowToUse extends StatefulWidget {
  @override
  _HowToUseState createState() => _HowToUseState();
}

class _HowToUseState extends State<HowToUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            //heading code
            Padding(
              padding: const EdgeInsets.only(top: 35.0, left: 10, right: 10),
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            padding: const EdgeInsets.only(left: 1.0, right: 1),
                            child: new Container(
                              width: MediaQuery.of(context).size.width - 85,
                              child: new Text(
                                "How to Use | Unseen Aura : Dark Web & Darknet",
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
            SizedBox(height: 25,),

            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 8,
                    right: 8,
                  ),
                  child: Text(
                    "HOW TO USE",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                )),

            Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8,
                  right: 8,
                ),
                child: Linkify(
                  onOpen: (link) {
                    _launchURL();
                  },
                  text: howtostart,
                  style: TextStyle(
                      color: textColor, fontFamily: 'ebrima', fontSize: 18,fontWeight: FontWeight.bold),
                  linkStyle: TextStyle(
                      color: Colors.yellow, fontFamily: 'ebrima', fontSize: 18),
                )),
            SizedBox(
              height: 15,
            ),

            Image(
              image: AssetImage("assets/tor.png"),
              height: 52,
              width: 52,
            ),

            Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8,
                  right: 8,
                ),
                child: Linkify(
                  text: "Clicking this icon, link will open in TOR browser",
                  style: TextStyle(
                      color: textColor, fontFamily: 'ebrima', fontSize: 18,fontWeight: FontWeight.bold),
                  linkStyle: TextStyle(
                      color: Colors.yellow, fontFamily: 'ebrima', fontSize: 18,fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 15,
            ),

            Icon(
              Icons.copy,
              color: Colors.white,
              size: 52,
            ),

            Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8,
                  right: 8,
                ),
                child: Linkify(
                  text: "Clicking this icon, link will be copied to Cipboard",
                  style: TextStyle(
                      color: textColor, fontFamily: 'ebrima', fontSize: 18,fontWeight: FontWeight.bold),
                  linkStyle: TextStyle(
                      color: Colors.yellow, fontFamily: 'ebrima', fontSize: 18),
                )),
          ],
        ));
  }

  _launchURL() async {
    const url =
        "https://apps.apple.com/us/app/onion-browser/id519296448";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
