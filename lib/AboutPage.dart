import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'config.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(children: [
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
                              "ABOUT | Unseen Aura : Dark Web & Darknet",
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 1,
                              style: TextStyle(fontSize: 22,
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

          Container(
            height: MediaQuery.of(context).size.height - 120,
            child: ListView(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: Text(
                        "ABOUT",
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
                      text: about,
                      style: TextStyle(
                          color: textColor, fontFamily: 'ebrima', fontSize: 18,fontWeight: FontWeight.bold),
                      linkStyle: TextStyle(
                          color: Colors.yellow,
                          fontFamily: 'ebrima',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 18,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 8,
                        right: 8,
                      ),
                      child: Text(
                        "DISCLAIMER",
                        style: TextStyle(
                            color: textColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(height: 18),
                Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 8,
                      right: 8,
                      bottom: 28,
                    ),
                    child: Linkify(
                      onOpen: (link) {
                        _launchURL();
                      },
                      text: disclaimer,
                      style: TextStyle(
                          color: textColor, fontFamily: 'ebrima', fontSize: 18,fontWeight: FontWeight.bold),
                      linkStyle: TextStyle(
                          color: Colors.yellow,
                          fontFamily: 'ebrima',
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
              
               Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 8,
                        right: 8,
                      ),
                      child: Text(
                        "About Developer",
                        style: TextStyle(
                            color: textColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    )),

                    SizedBox(height: 18),
                Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 8,
                      right: 8,
                      bottom: 28,
                    ),
                    child: Linkify(
                      onOpen: (link) {
                        _launchURLkk4();
                      },
                      text: aboutDev,
                      style: TextStyle(
                          color: textColor, fontFamily: 'ebrima', fontSize: 18,fontWeight: FontWeight.bold),
                      linkStyle: TextStyle(
                          color: Colors.yellow,
                          fontFamily: 'ebrima',
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
              

                   

              ],
            ),
          )
        ]));
  }

  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'info@bottlecaptech.com',
      queryParameters: {'subject': ''});

  _launchURL() async {
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not send email ';
    }
  }
  final Uri _kk4emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'karankharode.kk@gmail.com',
      queryParameters: {'subject': ''});

  _launchURLkk4() async {
    if (await canLaunch(_kk4emailLaunchUri.toString())) {
      await launch(_kk4emailLaunchUri.toString());
    } else {
      throw 'Could not send email ';
    }
  }
}
