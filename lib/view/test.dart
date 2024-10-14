import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class VerticalStackScrollView extends StatefulWidget {
  const VerticalStackScrollView({super.key});
  
  @override
  _VerticalStackScrollViewState createState() =>_VerticalStackScrollViewState();
}

class _VerticalStackScrollViewState extends State<VerticalStackScrollView> {
  final ScrollController _scrollController = ScrollController();
  bool isStacked = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Detect scroll direction and update the stacking state
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          isStacked = false;
        });
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          isStacked = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            print('Scroll Notification: ${scrollNotification.metrics.pixels}');
          }
          return true;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // First widget
              Container(height: 600, color: Colors.green),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: isStacked ? 50 : 400, // Increase unstacked height
                color: Colors.red,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: Colors.red[800],
                      child: const Center(
                          child: Text("Widget 1 Header",
                              style: TextStyle(color: Colors.white))),
                    ),
                    if (!isStacked)
                      Expanded(
                        child: const Center(
                            child: Text("Widget 1 Content",
                                style: TextStyle(color: Colors.white))),
                      ),
                  ],
                ),
              ),


              // Spacer at the bottom to ensure there's enough height to scroll
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: isStacked ? 50 : 400, // Increase unstacked height
                color: Colors.blue,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: Colors.blue[800],
                      child: const Center(
                          child: Text("Widget 2 Header",
                              style: TextStyle(color: Colors.white))),
                    ),
                    if (!isStacked)
                      Expanded(
                        child: const Center(
                            child: Text("Widget 2 Content",
                                style: TextStyle(color: Colors.white))),
                      ),
                  ],
                ),
              ),
              Container(height: 100, color: Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: VerticalStackScrollView()));
}
