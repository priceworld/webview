import 'dart:io';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/link.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 2;
  final tabs = [
//Exit
    Center(
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        onPressed: () => exit(0),
        child: Text('Exit the application'),
      ),
    ),
//share
    Center(child: Text('Share')),
//Webview
    Center(
      child: WebView(
        allowsInlineMediaPlayback: false,
        debuggingEnabled: false,
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        //initialUrl: "https://b2b.tarikediz.com/",
        initialUrl: "https://emirhancelik.com/",
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: Set.from([
          JavascriptChannel(
            name: "flutter",
            onMessageReceived: (JavascriptMessage message) {
              if (message.message == "onSubscribeClick") {
                print("onSubscribeClick");
              }
            },
          )
        ]),
        onWebViewCreated: (WebViewController webviewcontroller) {
          try {} catch (error, stackTrace) {}
        },
        onPageStarted: (String page) {},
        onPageFinished: (String page) {},
        onWebResourceError: (websourceerror) {
          print("=> onWebResourceError " + websourceerror.domain.toString());
        },
      ),
    ),
//Rate us
    Center(child: Text('Rate')),
//Settings
    Center(
        child: Scaffold(
            body: Container(
              child: Column(children: [
                SizedBox(
                  height: 50,
                ),
                // Mail adress text
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'E-Posta: destek@tarikediz.com',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //rate us button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        //icon: Icon(Icons.rate),
                      ),
                      onPressed: () async {
                        const String _url =
                            "https://play.google.com/store/apps/details?id=com.tarik.ediz";
                        if (await canLaunch(_url)) {
                          launch(_url);
                        } else {
                          throw "Could not launch $_url";
                        }
                      },
                      child: Text('Rate Us'),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),
                //share button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () async {
                      await FlutterShare.share(
                          title: 'Example share',
                          text: 'Example share text',
                          linkUrl:
                              'https://play.google.com/store/apps/details?id=com.tarik.ediz',
                          chooserTitle: 'Example Chooser Title');
                    },
                    child: Text('Share'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //Privacy policy
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () async {
                      const String _url =
                          "https://www.tarikediz.com/en/privacy-policy/";
                      if (await canLaunch(_url)) {
                        launch(_url);
                      } else {
                        throw "Could not launch $_url";
                      }
                    },
                    child: Text('Privacy Policy'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ]),
            ),
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('Settings'),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ))),
  ];
  //Navigation Bar
  @override
  Widget build(BuildContext context) {
    const String _url =
        'https://play.google.com/store/apps/details?id=com.tarik.ediz';
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.black,
          iconSize: 25,
          selectedFontSize: 15,
          unselectedFontSize: 12,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.close),
              label: 'Exit',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.share),
              label: 'Share',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.rate_review_rounded),
              label: 'Rate',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: Colors.black,
            ),
          ],
          onTap: (index) async {
            if (index == 1) {
              await FlutterShare.share(
                  title: 'Example share',
                  text: 'Example share text',
                  linkUrl:
                      'https://play.google.com/store/apps/details?id=com.tarik.ediz',
                  chooserTitle: 'Example Chooser Title');
            } else if (index == 3) {
              await launch(_url);
            } else {
              setState(() {
                _currentIndex = index;
              });
            }
          }),
    );
  }
}
