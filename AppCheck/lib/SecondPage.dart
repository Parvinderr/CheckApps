import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_play_store_scraper_dart/google_play_store_scraper_dart.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:uninstall_apps/uninstall_apps.dart';

import 'colorList.dart';

class SecondPage extends StatefulWidget {
  final String appId;
  final int numb;
  final String appName;
  SecondPage({
    this.appId,
    this.numb,
    this.appName,
  });
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  GooglePlayScraperDart scraper = GooglePlayScraperDart();
  var result;
  Future _getScrapedData(String id) async {
    var data = await scraper.app(appID: id);
    setState(() {
      result = data;
    });
    print(result);
  }

  Future uninstallApp() async {
    await UninstallApps.uninstall(widget.appId);
  }

  String mail;

  @override
  void initState() {
    super.initState();
    _getScrapedData(widget.appId);

    print(widget.numb);
  }

  ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    return widget.appName == null
        ? Center(
            child: LoadingBouncingGrid.square(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                widget.appName,
              ),
              backgroundColor: colorItem[widget.numb],
            ),
            backgroundColor: Colors.grey[300],
            body: result == null
                ? Center(
                    child: LoadingBouncingLine.circle(),
                  )
                : SafeArea(
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 110,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[800],
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      16,
                                    ),
                                    image: result['icon'] == null
                                        ? null
                                        : DecorationImage(
                                            image: NetworkImage(
                                              result['icon'],
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                      12,
                                      4,
                                      2,
                                      0,
                                    ),
                                    decoration: BoxDecoration(),
                                    child: Text(
                                      result['title'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 48,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.deepPurple[700],
                                      width: 1.4,
                                    ),
                                  ),
                                  child: MaterialButton(
                                    child: Center(
                                      child: Text(
                                        'Uninstall',
                                      ),
                                    ),
                                    color: Colors.grey[100],
                                    textColor: Colors.grey[800],
                                    colorBrightness: Brightness.light,
                                    highlightColor: Colors.orangeAccent,
                                    hoverColor: Colors.yellowAccent,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            elevation: 6,
                                            backgroundColor: Colors.grey[100],
                                            buttonPadding: EdgeInsets.all(12),
                                            title: Text(
                                              'Do You Really Want To Uninstall?',
                                            ),
                                            actions: [
                                              FlatButton(
                                                onPressed: () => uninstallApp(),
                                                child: Text(
                                                  'Yes',
                                                ),
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'No',
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  height: 48,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.deepPurple[700],
                                      width: 1.4,
                                    ),
                                  ),
                                  child: MaterialButton(
                                    color: Colors.grey[100],
                                    textColor: Colors.grey[800],
                                    colorBrightness: Brightness.light,
                                    highlightColor: Colors.orangeAccent,
                                    hoverColor: Colors.yellowAccent,
                                    child: Center(
                                      child: Text(
                                        'Open',
                                      ),
                                    ),
                                    onPressed: () {
                                      if (widget.appId != null) {
                                        setState(() {
                                          AppAvailability.launchApp(
                                              widget.appId);
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[800],
                                ),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  FlutterIcons.address_book_faw5,
                                  size: 36,
                                ),
                                title: Text(
                                  'Developer\'s Contact:',
                                ),
                                subtitle: Text(
                                  result['developerAddress'],
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.mail,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Scrollbar(
                              controller: _controller,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[700],
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    22,
                                  ),
                                ),
                                margin: EdgeInsets.all(
                                  3,
                                ),
                                padding: EdgeInsets.fromLTRB(
                                  12,
                                  12,
                                  8,
                                  4,
                                ),
                                child: SingleChildScrollView(
                                  child: Text(
                                    result['description'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
  }
}
