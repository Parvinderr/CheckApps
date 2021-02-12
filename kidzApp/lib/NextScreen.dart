import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidzApp/Painter.dart';
import 'Lists.dart';

class NextScreen extends StatefulWidget {
  final int n;
  NextScreen({this.n});
  @override
  NextScreenState createState() => NextScreenState();
}

class NextScreenState extends State<NextScreen> {
  FlutterTts _tts = FlutterTts();
  bool isSpeaking = false;
  // TtsState ttsState = TtsState.stopped;

  Future _speak(String text) async {
    _tts.setSpeechRate(0.63);
    _tts.setVolume(0.90);

    _tts.setPitch(1);
    _tts.awaitSpeakCompletion(true);
    var result = await _tts.speak(text);
    if (result == 1) {
      setState(() {
        _tts.startHandler();
      });
    }
  }

  Future _onComplete() async {
    setState(() {
      _tts.completionHandler();
    });
  }

  initTts() {
    _tts.setStartHandler(
      () {
        setState(
          () {
            isSpeaking = true;
            print('Start');
          },
        );
      },
    );
    _tts.setCompletionHandler(
      () {
        setState(
          () {
            isSpeaking = false;
            print('Completed');
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initTts();
    _onComplete();
  }

  @override
  void dispose() {
    super.dispose();
    _tts.stop();
  }

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
      body: Material(
        child: ListView.builder(
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
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
                  ),
                  Positioned(
                    child: Container(
                      height: 185,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            12,
                          ),
                          bottomRight: Radius.elliptical(
                            40,
                            80,
                          ),
                          topRight: Radius.elliptical(
                            40,
                            80,
                          ),
                          bottomLeft: Radius.lerp(
                            Radius.circular(
                              40,
                            ),
                            Radius.circular(
                              40,
                            ),
                            100,
                          ),
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            'images/apple.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 62,
                    left: MediaQuery.of(context).size.width / 1.79,
                    child: Material(
                      color: Colors.grey[200],
                      child: Center(
                        child: Text(
                          lists[widget.n][i],
                          style: GoogleFonts.sansita(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // top: 3,
                    left: MediaQuery.of(context).size.width / 1.2,
                    child: IconButton(
                      icon: Icon(
                        Icons.developer_board_sharp,
                        size: 28,
                        color: Colors.grey[700],
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => Signature(
                          height: 20,
                          width: 1,
                          title: lists[widget.n][i],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 22,
                      left: MediaQuery.of(context).size.width / 1.23,
                      child: IconButton(
                        icon: Container(
                          height: 28,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey[800],
                            ),
                          ),
                          child: Icon(Icons.play_arrow),
                        ),
                        onPressed: () {
                          setState(() {
                            _speak(lists[widget.n][i]);
                          });
                        },
                      )),
                ],
              ),
            );
          },
          itemCount: lists[widget.n].length,
        ),
      ),
    );
  }
}
