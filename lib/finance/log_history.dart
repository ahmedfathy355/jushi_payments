
import 'package:flutter/material.dart';

class LogHistory extends StatefulWidget {
  @override
  _LogHistoryState createState() => _LogHistoryState();
}

class _LogHistoryState extends State<LogHistory>  {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
      Column(
        children: <Widget>[
          Text('AA'),
          Text('AA')
        ],
      )
      ,);
  }
}
