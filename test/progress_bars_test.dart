import 'package:flutter/material.dart';
import 'package:progress_bars/progress_bars.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Page(),
      ),
    );
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  String text = 'Press To Load';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
      alignment: Alignment(0, 0.6),
      child: FlatButton(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        color: Colors.orange,
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Center(
                  child: CircleProgressBar(
                    backgroundColor: Colors.black54,
                    progressColor: Colors.orange,
                    size: 40,
                    child: SizedBox(child: FlutterLogo()),
                  ),
                );
              });
          Future.delayed(Duration(seconds: 10)).then((value) {
            Navigator.pop(context);
            setState(() {
              text = "LOADED";
            });
          });
        },
      ),
    ));
  }
}
