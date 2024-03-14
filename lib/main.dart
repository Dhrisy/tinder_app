import 'package:flutter/material.dart';

import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:tinder_app/one.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
      routes: {
        '/one': (context) => const One(),
      },
    );
  }
}

class Content {
  final String? text;
  final Color? color;

  Content({this.text, this.color});
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String title = '';
  MatchEngine? _matchEngine;
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final List<String> _names = [
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Orange",
    "Grey",
    "Purple",
    "Pink"
  ];
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.grey,
    Colors.purple,
    Colors.pink
  ];

  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
            print('//////////////////////////////');
          },
          nopeAction: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('lkjhgfd')));
          },
          superlikeAction: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('mmmm')));
          },
          onSlideUpdate: (SlideRegion? region) async {
            debugPrint("Region $region");
          }));
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              child: SwipeCards(
                matchEngine: _matchEngine!,
                onStackFinished: () {
                  debugPrint('FINISHEDDDDD');
                  Navigator.pushReplacementNamed(context, "/one");
                },
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Container(
                      height: 500,
                      width: 350,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: _swipeItems[index].content.color,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const[
                            BoxShadow(
                                blurRadius: 8,
                                color: Colors.grey,
                                offset: Offset(0, 1))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            _swipeItems[index].content.text,
                            style: const TextStyle(fontSize: 100),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    _matchEngine!.currentItem?.nope();
                                    debugPrint('>>>>>>>>${_matchEngine!.currentItem}');
                                  },
                                  child: const Text("Nope")),
                              ElevatedButton(
                                  onPressed: () {
                                    _matchEngine!.currentItem?.superLike();
                                  },
                                  child: const Text("Superlike")),
                              ElevatedButton(
                                  onPressed: () {
                                    _matchEngine!.currentItem?.like();
                                  },
                                  child: const Text("Like"))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemChanged: (SwipeItem item, int index) {
                  print("item: ${item.content.text}, index: $index");
                },
                upSwipeAllowed: true,
                fillSpace: true,
                leftSwipeAllowed: true,
                rightSwipeAllowed: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
