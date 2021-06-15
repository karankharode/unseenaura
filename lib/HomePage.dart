import 'dart:io';
import 'dart:ui';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:unseenaura/AboutPage.dart';
import 'package:unseenaura/HowToUse.dart';
import 'package:unseenaura/config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'SecondPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final Map<String, Item> _items = <String, Item>{};
Item _itemForMessage(Map<String, dynamic> message) {
  final dynamic data = message['notification'] ?? message;
  final String itemId = data['title'];
  final String itemBody = data['body'];
  final Item item = _items.putIfAbsent(
      itemId, () => Item(itemId: itemId, itemBody: itemBody))
    ..status = data['status'];
  return item;
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Flutter Fcm Code
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Widget _buildDialog(BuildContext context, Item item) {
    return AlertDialog(
      content: Wrap(children: [
        Text(item.itemId.toString()),
        Text(item.itemBody.toString())
      ]),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, _itemForMessage(message)),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToItemDetail(message);
      }
    });
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final Item item = _itemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
  }

  @override
  void initState() {
    super.initState();
    FacebookAudienceNetwork.init(
        // testingId: '3ac7d398-0783-4621-af20-34580b5c7e96'
        );

    fcmconfigure();

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {});
    });
  }

  fcmconfigure() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

// change
      bottomNavigationBar: Container(   // change
        // alignment: Alignment(0.5, 1),
  child: FacebookBannerAd(
    placementId: Platform.isAndroid ? "352788939245858_352790095912409" : "YOUR_IOS_PLACEMENT_ID",
    bannerSize: BannerSize.STANDARD,
    listener: (result, value) {
          switch (result) {
            case BannerAdResult.ERROR:
      print("Error: $value");
      break;
            case BannerAdResult.LOADED:
      print("Loaded: $value");
      break;
            case BannerAdResult.CLICKED:
      print("Clicked: $value");
      break;
            case BannerAdResult.LOGGING_IMPRESSION:
      print("Logging Impression: $value");
      break;
          }
    },
  ),
      ),

      body: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      children: [
        //Heading Code

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
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Title
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Text(
                    "Unseen Aura : Dark Web & Darknet",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        fontFamily: 'ebrima'),
                  ),
                ),
              ),
            ),

            // icon 1
            IconButton(
                icon: Image(
                  image: AssetImage('assets/about.png'),
                  height: 24,
                  width: 24,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AboutPage()),
                  );
                }),

            //Icon 2
            IconButton(
                icon: Image(
                  image: AssetImage('assets/help.png'),
                  height: 24,
                  width: 24,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HowToUse()),
                  );
                })
          ],
        ),
      ),
            ),
          ),
        ),

        //Heading Code -- end

        //       //DownloadLink
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
          child: Container(
            height: 58,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
        color: downloadBlock,
        borderRadius: BorderRadius.all(Radius.circular(25))),
            child: InkWell(
      onTap: () {
        _launchURL();
      },
      child: Padding(
        padding:
            const EdgeInsets.only(top: 6.0, left: 11, right: 11),
        child: Text(
          "Download TOR Browser to access Dark Web Links \n Click Here ",
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
            ),
          ),
        ),

        //       //DownloadLink -- end

        //       //Drugs Block
        Padding(
          padding: const EdgeInsets.only(
      top: 20.0, left: 10, right: 10, bottom: 10),
          child: InkWell(
            onTap: () {
      setState(() {
        pageIndex = 6;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondPage()),
      );
            },
            child: Container(
      height: 110,
      decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.all(Radius.circular(26))),
      child: Center(
        child: Column(children: [
          // Image
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 60,
              child: Image(
                image: AssetImage("assets/drugs.png"),
              ),
            ),
          ),
          // Text
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('DRUGS',
                style: TextStyle(
                    color: textColor,
                    fontFamily: 'ebrima',
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          )
        ]),
      ),
            ),
          ),
        ),


        SizedBox(height: 10,),
        //       // grid layout
        Container(
          
          height: ((MediaQuery.of(context).size.width/3)*3), // change
          child: GridView.count(
            
            crossAxisCount: 2,
            childAspectRatio: (2 / 1.2),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: List.generate(6, (index) {
      return Padding(
        padding: const EdgeInsets.only(
            top: 8.0, left: 8, right: 8, bottom: 8),
        child: Container(
          decoration: BoxDecoration(
              color: tileColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(20))),
          height: 60,
          child: InkWell(
            onTap: () {
            setState(() {
              print("page index : $index");
              pageIndex = index;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondPage()),
            );
          },
                      child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    child: Image(
                      image:
                          AssetImage(pageNames[index]['imgPath']),
                    ),
                  ),
                ),
                Text(pageNames[index]['name'],
                    style: TextStyle(
                        color: textColor,
                        fontFamily: 'ebrima',
                        fontSize: 16,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      );
            }),
          ),
        ),

        // sized box


        // Facebook ad container
        
        Container(
  alignment: Alignment(0.5, 1),
  child: FacebookBannerAd(
    placementId: Platform.isAndroid ? "352788939245858_352790095912409" : "YOUR_IOS_PLACEMENT_ID",
    bannerSize: BannerSize.STANDARD,
    listener: (result, value) {
          switch (result) {
            case BannerAdResult.ERROR:
      print("Error: $value");
      break;
            case BannerAdResult.LOADED:
      print("Loaded: $value");
      break;
            case BannerAdResult.CLICKED:
      print("Clicked: $value");
      break;
            case BannerAdResult.LOGGING_IMPRESSION:
      print("Logging Impression: $value");
      break;
          }
    },
  ),
)
      // Container(
      //   height: 79,
      //   color: Colors.white,
      // )
      ],
            ),
          ),
    );
  }
// change

  _launchURL() async {
    const url =
        "https://play.google.com/store/apps/details?id=org.torproject.torbrowser";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
