import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  @override
  HelpState createState() => HelpState();
}

class HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help',
        ),
      ),
      body: Container(
        child: Center(
          child: Text(
            'Help Page',
          ),
        ),
      ),
    );
  }
}
