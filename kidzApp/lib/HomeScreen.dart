import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidzApp/Painter.dart';
import 'HelpPage.dart';
import 'Lists.dart';
import 'NextScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[500],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              13,
            ),
            topRight: Radius.circular(
              13,
            ),
          ),
        ),
        title: Text(
          'KidzApp',
        ),
      ),
      drawer: AnimatedContainer(
        duration: Duration(
          microseconds: 50000,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 1.70,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[400],
          ),
          color: Colors.green[200],
          borderRadius: BorderRadius.only(
            topRight: Radius.elliptical(
              900000,
              900000,
            ),
            bottomRight: Radius.elliptical(
              900000,
              900000,
            ),
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(
                  8.0,
                ),
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.red[400],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  8.0,
                ),
                child: Container(
                  child: Text(
                    'KidzApp',
                    style: GoogleFonts.aladin(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[400],
                    ),
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  child: MaterialButton(
                    color: Colors.grey[200],
                    splashColor: Colors.redAccent,
                    focusColor: Colors.purpleAccent,
                    highlightColor: Colors.lightGreen[200],
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Signature(
                            title: "Practice",
                          ),
                        ),
                      );
                      print(
                        'Practice Clicked',
                      );
                    },
                    child: Center(
                      child: Text(
                        'Practice',
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                    border: Border.all(
                      color: Colors.grey[400],
                    ),
                  ),
                  child: MaterialButton(
                    color: Colors.grey[200],
                    splashColor: Colors.redAccent,
                    focusColor: Colors.purpleAccent,
                    highlightColor: Colors.lightGreen[200],
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Help(),
                        ),
                      );
                      print(
                        'Help Clicked',
                      );
                    },
                    child: Center(
                      child: Text(
                        'Help',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Material(
            elevation: 6,
            child: ListView.builder(
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NextScreen(n: i),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                            16,
                          ),
                          bottomLeft: Radius.circular(
                            16,
                          ),
                          bottomRight: Radius.elliptical(
                            40,
                            35,
                          ),
                        ),
                        border: Border.all(
                          color: Colors.grey[400],
                        ),
                        color: Colors.grey[200],
                      ),
                      height: 160,
                      child: Center(
                        child: Text(
                          items[i],
                          style: GoogleFonts.aBeeZee(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: items.length,
            ),
          )
        ],
      ),
    );
  }
}
