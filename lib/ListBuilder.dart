import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unseenaura/config.dart';
import 'package:url_launcher/url_launcher.dart';

List drugData = [];
List hitmanData = [];
List rentHackerData = [];
List weaponStoreData = [];
List fraudDocxData = [];
List bitcoinCasinoData = [];
List redRoomData = [];
List dataToShow = [];

class Listbuilder extends StatefulWidget {
  @override
  _ListbuilderState createState() => _ListbuilderState();
}

class _ListbuilderState extends State<Listbuilder> {
  @override
  void initState() {
    super.initState();
    if (isNotDownloaded) {
      DatabaseReference ref = FirebaseDatabase.instance.reference();
      ref.child('Categories').once().then((DataSnapshot dataSnapshot) {
        isNotDownloaded = false;

        // var keys = dataSnapshot.value.keys;
        var data = dataSnapshot.value;
        drugData.clear();
        hitmanData.clear();
        rentHackerData.clear();
        weaponStoreData.clear();
        fraudDocxData.clear();
        bitcoinCasinoData.clear();
        redRoomData.clear();
        dataToShow.clear();
        var counter = 0;

        for (var key in data['DRUGS']) {
          if (counter != 0) {
            // print(key['url']);
            drugData.add(key['url']);
          }
          counter = 1;
        }

        counter = 0;
        for (var key in data['HITMAN']) {
          if (counter != 0) {
            // print(key['url']);
            hitmanData.add(key['url']);
          }
          counter = 1;
        }

        counter = 0;
        for (var key in data["FRAUD DOCX"]) {
          if (counter != 0) {
            // print(key['url']);
            fraudDocxData.add(key['url']);
          }
          counter = 1;
        }

        counter = 0;
        for (var key in data["WEAPON STORE"]) {
          if (counter != 0) {
            // print(key['url']);
            weaponStoreData.add(key['url']);
          }
          counter = 1;
        }

        counter = 0;
        for (var key in data["RENT HACKER"]) {
          if (counter != 0) {
            // print(key['url']);
            rentHackerData.add(key['url']);
          }
          counter = 1;
        }

        counter = 0;
        for (var key in data["BITCOIN CASINO"]) {
          if (counter != 0) {
            // print(key['url']);
            bitcoinCasinoData.add(key['url']);
          }
          counter = 1;
        }

        counter = 0;
        for (var key in data["RED ROOM"]) {
          if (counter != 0) {
            // print(key['url']);
            redRoomData.add(key['url']);
          }
          counter = 1;
        }
        setState(() {
          switch (pageIndex + 1) {
            case 1:
              dataToShow = hitmanData;
              break;
            case 2:
              dataToShow = rentHackerData;
              break;
            case 3:
              dataToShow = weaponStoreData;
              break;
            case 4:
              dataToShow = fraudDocxData;
              break;
            case 5:
              dataToShow = bitcoinCasinoData;
              break;
            case 6:
              dataToShow = redRoomData;
              break;
            case 7:
              dataToShow = drugData;
              break;
            default:
              dataToShow = [];
          }
          
        });
      });
    } else {
      setState(() {
        switch ((pageIndex + 1)) {
          case 1:
            dataToShow = hitmanData;
            break;
          case 2:
            dataToShow = rentHackerData;
            break;
          case 3:
            dataToShow = weaponStoreData;
            break;
          case 4:
            dataToShow = fraudDocxData;
            break;
          case 5:
            dataToShow = bitcoinCasinoData;
            break;
          case 6:
            dataToShow = redRoomData;
            break;
          case 7:
            dataToShow = drugData;
            break;
          default:
            dataToShow = hitmanData;
        }
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: dataToShow.length == 0
            ? Center(
                child: new CircularProgressIndicator(
                backgroundColor: textColor,
              ))
            : new ListView.builder(
                padding: EdgeInsets.only(
                  left: 14,
                  right: 14,
                ),
                itemCount: dataToShow.length,
                itemBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    height: 45,
                    margin: EdgeInsets.only(top: 1),
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Link Container
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 3.0, right: 7, top: 7),
                              child: InkWell(
                                onTap: () {
                                  _launchURL(dataToShow[index].toString());
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 125,
                                  height: 32,
                                  decoration: BoxDecoration(
                                      color: tileColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(13))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 10, top: 3),
                                    child: Text(
                                      ' ${index + 1}. ${dataToShow[index]}',
                                      maxLines: 1,
                                      // overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          color: textColor, fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Tor Icon
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              height: 29,
                              width: 29,
                              child: InkWell(
                                  onTap: () {
                                    _openTorBrowser(
                                        dataToShow[index].toString());
                                    // _launchURL(
                                    //     dataToShow[index].toString());
                                  },
                                  child: Image(
                                      image: AssetImage("assets/tor.png"))),
                            ),
                          ),

                          // copy icon
                          Container(
                            padding: EdgeInsets.only(top: 4),
                            child: IconButton(
                              onPressed: () {
                                // print("${dataToShow[index]}");
                                Clipboard.setData(new ClipboardData(
                                        text: dataToShow[index]))
                                    .then((value) => {
                                          // Fluttertoast.cancel(),
                                          Fluttertoast.showToast(
                                            msg: "Link Copied",
                                            backgroundColor: tileColor,
                                            textColor: textColor,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                          )
                                        });
                              },
                              icon: Icon(
                                Icons.copy,
                                size: 28,
                              ),
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openTorBrowser(data) async {
      if (await canLaunch(data))
        await launch(data);
      else
        throw 'Could not launch $data';
    
  }
}
