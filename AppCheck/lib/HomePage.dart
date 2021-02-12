import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';
import 'dart:async';
import 'dart:io';
import 'colorList.dart';
import 'SecondPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> installedApps;

  int ran;
  @override
  void initState() {
    super.initState();
    print(ran);
  }

  Future<void> getApps() async {
    List<Map<String, String>> _installedApps;
    if (Platform.isAndroid) {
      _installedApps = await AppAvailability.getInstalledApps();
    }
    setState(() {
      installedApps = _installedApps;
    });
  }

  @override
  Widget build(BuildContext context) {
    ran = Random().nextInt(colorItem.length - 1);
    if (installedApps == null) getApps();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Check',
        ),
        backgroundColor: colorItem[ran],
      ),
      backgroundColor: Colors.grey[100],
      body: installedApps == null
          ? Center(child: LoadingBouncingLine.circle())
          : Container(
              child: ListView.builder(
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SecondPage(
                            appId: installedApps[i]['package_name'],
                            appName: installedApps[i]['app_name'],
                            numb: ran,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      hoverColor: Colors.purpleAccent,
                      selectedTileColor: Colors.yellowAccent,
                      tileColor: Colors.grey[100],
                      focusColor: Colors.red[100],
                      contentPadding: EdgeInsets.all(
                        6,
                      ),
                      title: Text(
                        installedApps[i]['app_name'],
                        style: GoogleFonts.farro(),
                      ),
                      subtitle: Text(
                        installedApps[i]['package_name'],
                        style: GoogleFonts.pacifico(),
                      ),
                    ),
                  );
                },
                itemCount: installedApps.length,
              ),
            ),
    );
  }
}
