import 'package:flutter/material.dart';

class DraggableTest extends StatefulWidget {
  @override
  _DraggableTestState createState() => _DraggableTestState();
}

class _DraggableTestState extends State<DraggableTest> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Listener(
              onPointerMove: (event) {
                setState(() {});
              },
              onPointerUp: (event) {
                setState(() {});
              },
              child: LongPressDraggable(
                data: 5,
                onDragCompleted: () {
                  print("complete");
                },
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      '5',
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                  ),
                  color: Colors.pink,
                ),
                feedback: Container(
                  width: 100.0,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      '5',
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                  ),
                  color: Colors.pink,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.green,
                  child: DragTarget(
                    builder: (context, List candidateData, rejectedData) {
                      print(candidateData);
                      return Center(
                        child: Text(
                          'Event',
                          style: TextStyle(color: Colors.white, fontSize: 22.0),
                        ),
                      );
                    },
                    onWillAccept: (data) {
                      return true;
                    },
                    onAccept: (int data) {
                      if (data % 2 == 0) {
                        scaffoldKey.currentState!.showSnackBar(SnackBar(
                          content: Text('Correct!'),
                        ));
                      } else {
                        scaffoldKey.currentState!.showSnackBar(SnackBar(
                          content: Text('Wrong!'),
                        ));
                      }
                    },
                  ),
                ),
                Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.deepPurple,
                  child: DragTarget(
                    builder: (context, List candidateData, rejectedData) {
                      return Center(
                          child: Text(
                        "Odd",
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ));
                    },
                    onWillAccept: (data) {
                      return true;
                    },
                    onAccept: (int data) {
                      if (data % 2 != 0) {
                        scaffoldKey.currentState!
                            .showSnackBar(SnackBar(content: Text("Correct!")));
                      } else {
                        scaffoldKey.currentState!
                            .showSnackBar(SnackBar(content: Text("Wrong!")));
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
