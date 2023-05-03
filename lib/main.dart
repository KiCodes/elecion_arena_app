import 'package:election_arena_app/pages/createVote.dart';
import 'package:election_arena_app/theme/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:election_arena_app/constants/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: Consumer<MyAppState>(builder: (context, appState, child) {
        return MaterialApp(
          title: 'Election Arena',
          debugShowCheckedModeBanner: false,
          theme: darkThemeData(context),
          home: MyHomePage(),
        );
      }),
    );
  }
}

class MyAppState extends ChangeNotifier {}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  //slider variables
  int _currentIndex = 0;
  final List _imageList = [
    'assets/images/elections_01.png',
    'assets/images/elections_02.png',
    'assets/images/elections_04.png',
    'assets/images/elections_08.png',
    'assets/images/elections_09.png',
    'assets/images/elections_10.png',
  ];
  late AnimationController _animationController;
  double _xOffset = 0;

  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _currentIndex, viewportFraction: 0.8);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    bool _isLogin = false;

    _pageController.addListener(() {
      int nextPage = _pageController.page!.toInt();
      if (_pageController.page! - nextPage == 0.0) {
        setState(() {
          _currentIndex = nextPage;
        });
      }
      if (nextPage == _imageList.length) {
        _pageController.jumpToPage(0);
      } else if (nextPage < 0) {
        _pageController.jumpToPage(_imageList.length - 1);
      }
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.tertiary,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: AppBarPanel(
            theme: theme,
            isLogin: _isLogin,
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              icon: Icon(
                _isExpanded ? Icons.close : Icons.menu,
                color: theme.onBackground,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                    'Make Your Own Online Election Poll On Mobile Easily With ',
                                    style: TextStyle(color: theme.onBackground),
                                  ),
                                  TextSpan(
                                    text: 'ElectionArena',
                                    style: TextStyle(color: theme.secondary),
                                  ),
                                  TextSpan(
                                    text: 'Arena',
                                    style: TextStyle(color: theme.primary),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Fun polls to make with family and friends',
                            style: TextStyle(color: theme.inverseSurface),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //sliding images
                          Column(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  color: theme.inverseSurface,
                                  borderRadius: BorderRadius.circular(99),
                                ),
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                      depth: 56,
                                      intensity: 33,
                                      color: theme.inverseSurface,
                                      lightSource: LightSource(0.7, 0.7),
                                      shadowDarkColorEmboss: theme.inverseSurface,
                                      shadowLightColor: theme.inverseSurface.withOpacity(0.7),
                                      shadowLightColorEmboss: theme.inverseSurface,
                                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(99))
                                  ),
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: theme.inverseSurface,
                                      borderRadius: BorderRadius.circular(99),
                                    ),
                                    child: GestureDetector(
                                      onHorizontalDragEnd: (details) {
                                        if (details.primaryVelocity! > 0) {
                                          _pageController.previousPage(
                                              duration:
                                              Duration(milliseconds: 100),
                                              curve: Curves.easeInOut);
                                        } else if (details.primaryVelocity! < 0) {
                                          _pageController.nextPage(
                                              duration:
                                              Duration(milliseconds: 100),
                                              curve: Curves.easeInOut);
                                        }
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(99),
                                        child: PageView.builder(
                                          controller: _pageController,
                                          itemCount: _imageList.length,
                                          onPageChanged: (index) {
                                            setState(() {
                                              _currentIndex = index;
                                            });
                                          },
                                          itemBuilder: (context, index) {
                                            final actualIndex =
                                                index % _imageList.length;
                                            return Image.asset(
                                                _imageList[actualIndex]);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: _buildIndicator(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 90,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Neumorphic(
                                style: NeumorphicStyle(
                                    depth: 56,
                                    intensity: 33,
                                    color: theme.primary,
                                    lightSource: LightSource(0.7, 0.7),
                                    shadowDarkColorEmboss: theme.secondary,
                                    shadowLightColor: theme.primary.withOpacity(0.7),
                                    shadowLightColorEmboss: theme.secondary,
                                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16))
                                ),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(12, 1, 12, 1),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Votes',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: theme.onBackground),
                                      ),
                                      Text(
                                        '22,764',
                                        style: TextStyle(
                                            fontSize: 39, color: theme.secondary),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Neumorphic(
                                style: NeumorphicStyle(
                                    depth: 56,
                                    intensity: 33,
                                    color: theme.primary,
                                    lightSource: LightSource(0.7, 0.7),
                                    shadowDarkColorEmboss: theme.secondary,
                                    shadowLightColor: theme.primary.withOpacity(0.7),
                                    shadowLightColorEmboss: theme.secondary,
                                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16))
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: theme.primary,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: EdgeInsets.fromLTRB(12, 1, 12, 1),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Elections',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: theme.onBackground),
                                      ),
                                      Text(
                                        '9,000',
                                        style: TextStyle(
                                          fontSize: 39,
                                          color: theme.secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 90,
                          ),
                          NeumorphicButton(
                            onPressed: () {
                              _newElection(context);
                            },
                            style: NeumorphicStyle(
                                depth: 2,
                                intensity: 2,
                                color: theme.secondary,
                                lightSource: LightSource(1.4, 1.4),
                                shadowLightColor: theme.primary,
                                shadowDarkColorEmboss: theme.primary,
                                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.elliptical(36, 36)))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(1, 13, 1, 13),
                              child: Text(
                                'Start a free election',
                                style: TextStyle(
                                    color: theme.tertiary,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Explore service options',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: theme.onBackground),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 12,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _isExpanded
                                        ? Container(
                                      decoration: BoxDecoration(
                                          color: theme.primary),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'Home',
                                              style: TextStyle(
                                                color: theme.onBackground,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'Elections',
                                              style: TextStyle(
                                                color: theme.onBackground,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'Services',
                                              style: TextStyle(
                                                color: theme.onBackground,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'Pricing',
                                              style: TextStyle(
                                                color: theme.onBackground,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                        : SizedBox.shrink(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _imageList.length; i++) {
      indicators.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: CircleAvatar(
            radius: 4,
            backgroundColor:
            _currentIndex == i ? Colors.blue : Colors.grey[300],
          ),
        ),
      );
    }
    return indicators;
  }

  void _newElection(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height /2,
                padding: EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VoteDetails()),
                    );
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(fontSize: 27, color: theme.secondary),
                        children: [
                          TextSpan(
                            text: 'Create New',
                            style: TextStyle(color: theme.secondary),
                          ),
                          TextSpan(
                            text: ' +',
                            style:
                            TextStyle(color: theme.primary),
                          ),
                          TextSpan(
                            text: ' elections here',
                            style: TextStyle(color: theme.onBackground),
                          )
                        ]),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
