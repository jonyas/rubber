import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';

class ScrollPage extends StatefulWidget {

  ScrollPage({Key key}) : super(key: key);

  @override
  _ScrollPageState createState() => _ScrollPageState();

}

class _ScrollPageState extends State<ScrollPage> with SingleTickerProviderStateMixin {

  RubberAnimationController _controller;

  ScrollController _scrollController = ScrollController();
  TapGestureRecognizer _recognizer;

  int _taps1 = 0;
  int _taps2 = 0;

  @override
  void initState() {
    _recognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          _taps2++;
        });
      };
    _controller = RubberAnimationController(
        vsync: this,
        lowerBoundValue: AnimationControllerValue(pixel: 120),
        halfBoundValue: AnimationControllerValue(percentage: 0.5),
        duration: Duration(milliseconds: 200)
    );
    super.initState();
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scrolling $_taps1-$_taps2",style: TextStyle(color: Colors.cyan[900]),),
      ),
      body: Container(
        child: RubberBottomSheet(
          header: Container(
            height: 70,
            decoration: BoxDecoration(color: Colors.yellow),
          ),
          scrollController: _scrollController,
          lowerLayer: _getLowerLayer(),
          upperLayer: _getUpperLayer(),
          animationController: _controller,
        ),
      ),
    );
  }

  Widget _getLowerLayer() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.cyan[100]
      ),
    );
  }

  Widget _getUpperLayer() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.cyan
      ),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _taps1++;
              });
            },
            child: ListTile(
              subtitle: Text("subtitle"),
              title: RichText(
                text: TextSpan(
                  recognizer: _recognizer,
                  text: "Item $index"
                )
              )
            )
          );
        },
        itemCount: 100
      ),
    );
  }

}
