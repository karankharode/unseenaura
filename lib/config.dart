import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unseenaura/HomePage.dart';

Color backgroundColor = Color.fromRGBO(20, 21, 27, 1);
Color downloadBlock = Color.fromRGBO(43, 71, 207, 1);
Color tileColor = Color.fromRGBO(32, 34, 47, 1);
Color linkBoxColor = Color.fromRGBO(240, 240, 240, 1);
Color textColor = Color.fromRGBO(111, 118, 146, 1);

int pageIndex;

bool isNotDownloaded = true;

var pageNames = [
  {"name": "HITMAN", "imgPath": "assets/hitman.png"},
  {"name": "RENT HACKER", "imgPath": "assets/hacker.png"},
  {"name": "WEAPON STORE", "imgPath": "assets/weapon.png"},
  {"name": "FRAUD DOCX", "imgPath": "assets/frauddocx.png"},
  {"name": "BITCOIN CASINO", "imgPath": "assets/casino.png"},
  {"name": "RED ROOM", "imgPath": "assets/redroom.png"},
  {"name": "DRUGS", "imgPath": "assets/drugs.png"},
];

String appname = '';
String disclaimer =
    "This app is a result of our own experiences as well as research on the Deep/Dark web. That been said, we’ve never ordered products or used the deep/dark web for any illegal or illicit activity, neither do we intent to.\n\nWe visit these websites, talk to other users who’ve used these platforms on Reddit or other such forums, gather information from law-enforcement portals and websites (videos/interviews) and combine them with our own perspective of the website to form the articles that we publish over here.\n\nWe do not encourage, rather discourage you from using these sites for illegal means and any action, either illegal or otherwise is completely your own responsibility. If it’s just “information” you’re seeking, our articles should be more than enough to fill that gap; or there are other articles on the web you can go through.\n\nUsing the Dark Web to order products or services which are illegal by law in your country is still illegal and would land you in legal trouble if apprehended.\n\nIf you’ve any problems regarding any of the content, write us at\n\ninfo@bottlecaptech.com";
String about =
    "This app is tells you all about DARK WEB or DARKnet. You’ll find almost every type of dark web links, we’ll keep adding more categories, so you’ll never get unsatisfied.\n\nMeanwhile if you have any questions, queries or want some additional features, contact us by mail.\n\ninfo@bottlecaptech.com";

String howtostart =
    "First of all you need to download the encrypted browser, because no link will open without these browsers, our suggestion is to download TOR browser\n\nhttps://apps.apple.com/us/app/onion-browser/id519296448\n\nBefore opening any of the links, open TOR browser and click connect. Then go to your preferred category";
String aboutDev =
    "Karan Kharode is a student at Government College of Engineering, Amravati. He is an ambitious and real time programmer. He is fueled with his passion for developing cross-platform mobile applications. A teenager who considers himself a 'forever student'. Reach out to karankharode.kk@gmail.com to connect";
String appid = '';

String banner = '';

// FCM code

class Item {
  Item({this.itemId, this.itemBody});
  final String itemId;
  final String itemBody;

  StreamController<Item> _controller = StreamController<Item>.broadcast();
  Stream<Item> get onChanged => _controller.stream;

  String _status;
  String get status => _status;
  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {
    final String routeName = '/detail/$itemId';
    return routes.putIfAbsent(
      routeName,
      () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => HomePage(),
      ),
    );
  }
}
