import 'package:flutter/material.dart';
import 'package:kidzApp/Lists.dart';

class Pallete extends StatefulWidget {
  @override
  _PalleteState createState() => _PalleteState();
}

class _PalleteState extends State<Pallete> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      color: Colors.grey[200],
      child: ListView.builder(
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(
              8.0,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(
                  colorItem[i],
                );
                print(
                  'Selected Color:' + colorItem[i].toString(),
                );
              },
              child: Container(
                height: 60,
                width: 50,
                decoration: BoxDecoration(
                    color: colorItem[i],
                    border: Border.all(
                      color: Colors.grey[50],
                    ),
                    borderRadius: BorderRadius.circular(
                      16,
                    )),
              ),
            ),
          );
        },
        itemCount: colorItem.length,
      ),
    );
  }
}
