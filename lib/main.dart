import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tweet_ui/tweet_ui.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Black Resources App',
      theme: ThemeData(fontFamily: 'UnitedSans'),
      home: const Signin(),
    );
  }
}

class Signin extends StatelessWidget {
  const Signin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //welcome text
    Widget welcomeSection = Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: const Text(
              'Welcome,',
              style: TextStyle(fontSize: 40),
            ),
          ),
          const Text(
            'Please sign in.',
            style: TextStyle(fontSize: 32),
          ),
        ],
      ),
    );

    // sign in with BoilerKey (2-factor log in)
    Widget boilerKeyBtn = TextButton.icon(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
        backgroundColor: MaterialStateProperty.all(Colors.black),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
        fixedSize: MaterialStateProperty.all(const Size.fromWidth(350)),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      },
      label: const Text(
        'Sign in with Boilerkey',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      icon: const Icon(
        Icons.key,
        size: 40.0,
      ),
    );

    Widget guestBtn = Container(
      padding: const EdgeInsets.only(top: 20),
      child: TextButton.icon(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
          backgroundColor: MaterialStateProperty.all(const Color(0xff535353)),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
          fixedSize: MaterialStateProperty.all(const Size.fromWidth(350)),
        ),
        onPressed: () {},
        label: const Text(
          'Continue as Guest',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        icon: const Icon(
          Icons.portrait_rounded,
          size: 40.0,
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 50),
            child: Image.asset(
              'images/app-logo.png',
              width: 292,
              height: 245,
              fit: BoxFit.contain,
            ),
          ),
          welcomeSection,
          boilerKeyBtn,
          guestBtn
        ],
      ),
    );
  }
}

final List<String> imgList = [
  'images/news1.png',
  'images/news2.png',
  'images/news3.png'
];

final List<String> titleList = [
  'Purdue enrollment record-breaking, just under 50,000 students',
  'Purdue Welcomes Ukrainian Scholar Refugees',
  'Why New No. 1 Purdue Is a Legitimate National Title Contender'
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.only(bottom: 5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              child: Stack(
                children: <Widget>[
                  Image.asset(item,
                      fit: BoxFit.cover, width: 1000.0, height: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        titleList[imgList.indexOf(item)],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ],
              )),
        ))
    .toList();

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<Homepage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  Color _thumbsUpColor = Colors.black;
  Color _thumbsDownColor = Colors.black;
  bool thumbsup = false;
  bool thumbsdown = false;
  bool bookmark = false;
  Color _bookmarkColor = Colors.black;
  Icon bookmarkIcon = const Icon(Icons.bookmark_add);

  Color _thumbsUpColor2 = Colors.black;
  Color _thumbsDownColor2 = Colors.black;
  Color _bookmarkColor2 = Colors.black;
  bool thumbsup2 = false;
  bool thumbsdown2 = false;
  bool bookmark2 = false;
  Icon bookmarkIcon2 = const Icon(Icons.bookmark_add);

  @override
  Widget build(BuildContext context) {
    Widget newsBanner = Column(children: [
      Center(
        child: CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 20),
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 10.0,
              height: 10.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.5 : 0.2)),
            ),
          );
        }).toList(),
      ),
    ]);

    Widget rowButtons =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffB0B0B0)),
              borderRadius: BorderRadius.circular(8.0)),
          child: SizedBox.fromSize(
            size: const Size(100, 100),
            child: Material(
              color: const Color(0xffEDEDED),
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () {},
                child: Column(
                  children: const <Widget>[
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.new_releases, size: 50)),
                    Text(
                      "News",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffB0B0B0)),
              borderRadius: BorderRadius.circular(8.0)),
          child: SizedBox.fromSize(
            size: const Size(100, 100),
            child: Material(
              color: const Color(0xffEDEDED),
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MentorshipProgram()),
                  );
                },
                child: Column(
                  children: const <Widget>[
                    Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(Icons.supervisor_account, size: 50)),
                    Text(
                      "Mentorship Program",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffB0B0B0)),
              borderRadius: BorderRadius.circular(8.0)),
          child: SizedBox.fromSize(
            size: const Size(100, 100),
            child: Material(
              color: const Color(0xffEDEDED),
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () {},
                child: Column(
                  children: const <Widget>[
                    Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(Icons.stars, size: 50)),
                    Text(
                      "Community Goals",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);

    Widget discussion = Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      padding: const EdgeInsets.only(top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: const Text(
            'Discussion of the Week',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
        ),
        const Text(
          'Should Purdue implement a mentorship program for black students?',
          style: TextStyle(fontSize: 20.0, height: 1.5),
          textAlign: TextAlign.left,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DiscussionPage()),
                  );
                },
                style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(color: Color(0xffB0B0B0)),
                    ),
                    foregroundColor: MaterialStateProperty.all(Colors.black)),
                icon: const Icon(Icons.chat, size: 25),
                label:
                    const Text('Contribute', style: TextStyle(fontSize: 16.0))))
      ]),
    );

    Widget tweet = FutureBuilder(
      future: rootBundle.loadString('assets/tweet.json'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: EmbeddedTweetView.fromTweetV1(
              TweetV1Response.fromRawJson(
                snapshot.data,
              ),
              backgroundColor: Colors.white,
              createdDateDisplayFormat: DateFormat("EEE, MMM d, ''yy"),
            ),
          );
        }
        if (snapshot.hasError) {
          return Text(
            snapshot.error.toString(),
          );
        } else {
          return Container();
        }
      },
    );

    Widget upcomingEvents = Column(children: [
      Container(
        padding: const EdgeInsets.all(30.0),
        alignment: Alignment.centerLeft,
        child: const Text('Upcoming Events', style: TextStyle(fontSize: 30.0)),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EventMovieNight()),
                );
              },
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                width: 100,
                height: 130,
                decoration: BoxDecoration(
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: const Color(0xffB0B0B0))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          children: const [
                            Text(
                              '28',
                              style: TextStyle(fontSize: 30.0),
                            ),
                            Text(
                              'May',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            'Movie Night at BCC',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          )),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '9 PM',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EventCommencement()),
                );
              },
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                width: 100,
                height: 130,
                decoration: BoxDecoration(
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: const Color(0xffB0B0B0))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          children: const [
                            Text(
                              '15',
                              style: TextStyle(fontSize: 30.0),
                            ),
                            Text(
                              'May',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            '2022 Spring Commencement',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          )),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '2-5 PM',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EventGreekLife()),
                );
              },
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                width: 100,
                height: 130,
                decoration: BoxDecoration(
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: const Color(0xffB0B0B0))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          children: const [
                            Text(
                              '08',
                              style: TextStyle(fontSize: 30.0),
                            ),
                            Text(
                              'April',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            'Greek Life Farewell Dinner',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          )),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '6-9 PM',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BrowseSocial()),
                    );
                  },
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffB0B0B0)),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.black)),
                  child: const Text('View More Events',
                      style: TextStyle(fontSize: 16.0)))))
    ]);

    Widget topChats = Column(
      children: [
        Container(
          padding: const EdgeInsets.all(30.0),
          alignment: Alignment.centerLeft,
          child: const Text('Top Chats', style: TextStyle(fontSize: 30.0)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Thread1()),
            );
          },
          child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.only(bottom: 10.0),
              width: 350,
              height: 190,
              decoration: BoxDecoration(
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color(0xffB0B0B0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/placeholder.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            'Patrick Lopez',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: const Text(
                          '20 hours ago',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xff6B6B6B)),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Does anyone feel like Purdue needs a mentorship Program?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            height: 1.3),
                      )),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'I was thinking about this lately and I think that Purdue should consider implementing...',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14.0, height: 1.2),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: const Text(
                      'Read More',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                        height: 1.2,
                        color: Color(0xff982F0C),
                      ),
                    ),
                  ),
                  Stack(children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _thumbsUpColor = (thumbsup == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              _thumbsDownColor = Colors.black;
                              thumbsup = (_thumbsUpColor == Colors.black)
                                  ? false
                                  : true;
                              thumbsdown = false;
                            });
                          },
                          icon: Icon(
                            Icons.thumb_up,
                            color: _thumbsUpColor,
                            size: 20.0,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _thumbsDownColor = (thumbsdown == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              _thumbsUpColor = Colors.black;
                              thumbsdown = (_thumbsDownColor == Colors.black)
                                  ? false
                                  : true;
                              thumbsup = false;
                            });
                          },
                          icon: Icon(
                            Icons.thumb_down,
                            color: _thumbsDownColor,
                            size: 20.0,
                          ),
                        ),
                        const Text(
                          '30 comments',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14.0,
                            decoration: TextDecoration.underline,
                            color: Color(0xff982F0C),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _bookmarkColor = (bookmark == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              bookmark = (_bookmarkColor == Colors.black)
                                  ? false
                                  : true;
                              bookmarkIcon = (bookmark == true)
                                  ? const Icon(Icons.bookmark_added)
                                  : const Icon(Icons.bookmark_add);
                            });
                          },
                          icon: bookmarkIcon,
                          color: _bookmarkColor,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ]),
                ],
              )),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Thread2()),
            );
          },
          child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.only(bottom: 10.0),
              width: 350,
              height: 171,
              decoration: BoxDecoration(
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color(0xffB0B0B0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/placeholder.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            'Richard Miller',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: const Text(
                          '20 hours ago',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xff6B6B6B)),
                        ),
                      ),
                    ],
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Looking for advice!',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                height: 1.3),
                          ))),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'I would love to talk to an upperclassman about opportunities in the black...',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14.0, height: 1.2),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: const Text(
                      'Read More',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                        height: 1.2,
                        color: Color(0xff982F0C),
                      ),
                    ),
                  ),
                  Stack(children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _thumbsUpColor2 = (thumbsup2 == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              _thumbsDownColor2 = Colors.black;
                              thumbsup2 = (_thumbsUpColor2 == Colors.black)
                                  ? false
                                  : true;
                              thumbsdown2 = false;
                            });
                          },
                          icon: Icon(
                            Icons.thumb_up,
                            color: _thumbsUpColor2,
                            size: 20.0,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _thumbsDownColor2 = (thumbsdown2 == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              _thumbsUpColor2 = Colors.black;
                              thumbsdown2 = (_thumbsDownColor2 == Colors.black)
                                  ? false
                                  : true;
                              thumbsup2 = false;
                            });
                          },
                          icon: Icon(
                            Icons.thumb_down,
                            color: _thumbsDownColor2,
                            size: 20.0,
                          ),
                        ),
                        const Text(
                          '30 comments',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14.0,
                            decoration: TextDecoration.underline,
                            color: Color(0xff982F0C),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _bookmarkColor2 = (bookmark2 == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              bookmark2 = (_bookmarkColor2 == Colors.black)
                                  ? false
                                  : true;
                              bookmarkIcon2 = (bookmark2 == true)
                                  ? const Icon(Icons.bookmark_added)
                                  : const Icon(Icons.bookmark_add);
                            });
                          },
                          icon: bookmarkIcon2,
                          color: _bookmarkColor2,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ]),
                ],
              )),
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatForumPage()),
                    );
                  },
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffB0B0B0)),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.black)),
                  child: const Text('Explore Chat Forum',
                      style: TextStyle(fontSize: 16.0)),
                )))
      ],
    );

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: 60,
          title: const Text('Home', style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: ListView(children: [
          Column(children: [
            newsBanner,
            rowButtons,
            discussion,
            upcomingEvents,
            topChats,
            tweet
          ])
        ]));
  }
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //profile picture container
    Widget profilePic = Column(
      children: [
        Container(
          margin: const EdgeInsets.all(15),
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('images/profile-pic.jpg'), fit: BoxFit.fill),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: const Text(
            'Hello, Hannah.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );

    Widget navButtons = ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          TextButton.icon(
            style: ButtonStyle(
              alignment: Alignment.centerLeft,
              foregroundColor: MaterialStateProperty.all(Colors.black),
              fixedSize: MaterialStateProperty.all(const Size.fromWidth(375)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Homepage()),
              );
            },
            label: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                )),
            icon: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffA3A3A3)),
                    borderRadius: BorderRadius.circular(8.0)),
                padding: const EdgeInsets.all(5.0),
                child: const Icon(
                  Icons.home,
                  size: 30.0,
                )),
          ),
          TextButton.icon(
            style: ButtonStyle(
              alignment: Alignment.centerLeft,
              foregroundColor: MaterialStateProperty.all(Colors.black),
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              fixedSize: MaterialStateProperty.all(const Size.fromWidth(375)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ResourceCategories()),
              );
            },
            label: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Browse Resources',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                )),
            icon: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffA3A3A3)),
                    borderRadius: BorderRadius.circular(8.0)),
                padding: const EdgeInsets.all(5.0),
                child: const Icon(
                  Icons.search,
                  size: 30.0,
                )),
          ),
          TextButton.icon(
            style: ButtonStyle(
              alignment: Alignment.centerLeft,
              foregroundColor: MaterialStateProperty.all(Colors.black),
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              fixedSize: MaterialStateProperty.all(const Size.fromWidth(375)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatForumPage()),
              );
            },
            label: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Chat Forum',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                )),
            icon: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffA3A3A3)),
                    borderRadius: BorderRadius.circular(8.0)),
                padding: const EdgeInsets.all(5.0),
                child: const Icon(
                  Icons.chat,
                  size: 30.0,
                )),
          ),
          TextButton.icon(
            style: ButtonStyle(
              alignment: Alignment.centerLeft,
              foregroundColor: MaterialStateProperty.all(Colors.black),
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              fixedSize: MaterialStateProperty.all(const Size.fromWidth(375)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MentorshipProgram()),
              );
            },
            label: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Mentorship Program',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                )),
            icon: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffA3A3A3)),
                    borderRadius: BorderRadius.circular(8.0)),
                padding: const EdgeInsets.all(5.0),
                child: const Icon(
                  Icons.supervisor_account,
                  size: 30.0,
                )),
          ),
          TextButton.icon(
            style: ButtonStyle(
              alignment: Alignment.centerLeft,
              foregroundColor: MaterialStateProperty.all(Colors.black),
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              fixedSize: MaterialStateProperty.all(const Size.fromWidth(375)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Homepage()),
              );
            },
            label: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Map',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                )),
            icon: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffA3A3A3)),
                    borderRadius: BorderRadius.circular(8.0)),
                padding: const EdgeInsets.all(5.0),
                child: const Icon(
                  Icons.map_outlined,
                  size: 30.0,
                )),
          ),
          TextButton.icon(
            style: ButtonStyle(
              alignment: Alignment.centerLeft,
              foregroundColor: MaterialStateProperty.all(Colors.black),
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              fixedSize: MaterialStateProperty.all(const Size.fromWidth(375)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Homepage()),
              );
            },
            label: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Settings',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                )),
            icon: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffA3A3A3)),
                    borderRadius: BorderRadius.circular(8.0)),
                padding: const EdgeInsets.all(5.0),
                child: const Icon(
                  Icons.settings,
                  size: 30.0,
                )),
          )
        ]);

    Widget signoutBtn = Column(
      children: [
        Container(
          width: 265,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xffA3A3A3)))),
        ),
        OutlinedButton.icon(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
                const BorderSide(color: Color(0xffA3A3A3))),
            alignment: Alignment.center,
            foregroundColor: MaterialStateProperty.all(Colors.black),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            fixedSize: MaterialStateProperty.all(const Size.fromWidth(225)),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Signin()),
            );
          },
          label: const Text(
            'Sign Out',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          icon: const Icon(
            Icons.logout,
            size: 20.0,
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 60,
        title: const Text('Menu'),
        backgroundColor: const Color(0xff7D2721),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 30),
            icon: const Icon(Icons.close, size: 40.0),
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
        ],
      ),
      body: Center(
          child: Column(
        children: [profilePic, navButtons, signoutBtn],
      )),
    );
  }
}

class DiscussionPage extends StatefulWidget {
  const DiscussionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DiscussionPageState();
  }
}

class _DiscussionPageState extends State<DiscussionPage> {
  Color _thumbsUpColor = Colors.black;
  Color _thumbsDownColor = Colors.black;
  int thumbsUpCounter = 4;
  int thumbsDownCounter = 1;
  bool thumbsup = false;
  bool thumbsdown = false;

  Color _thumbsUpColor2 = Colors.black;
  Color _thumbsDownColor2 = Colors.black;
  int thumbsUpCounter2 = 9;
  int thumbsDownCounter2 = 0;
  bool thumbsup2 = false;
  bool thumbsdown2 = false;

  @override
  Widget build(BuildContext context) {
    Widget discussion = Container(
        padding: const EdgeInsets.all(30.0),
        height: 250,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text('Discussion of the Week',
                      style: TextStyle(
                          fontSize: 34.0, fontWeight: FontWeight.bold))),
              Text(
                  'Should Purdue implement a mentorship program for black students?',
                  style: TextStyle(fontSize: 24.0))
            ]));

    Widget comments = Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        decoration: const BoxDecoration(
            border:
                Border(top: BorderSide(color: Color(0xffA3A3A3), width: 3.0))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Text(
                      'Comments',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  Icon(Icons.chat),
                  Text(' 2', style: TextStyle(fontSize: 24))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  width: 350,
                  height: 140,
                  decoration: BoxDecoration(
                      color: const Color(0xffEDEDED),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: const Color(0xffB0B0B0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          AssetImage('images/placeholder.png'),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              const Text(
                                'FirstName LastName',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: const Text(
                              '3 hours ago',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 12.0, color: Color(0xff6B6B6B)),
                            ),
                          ),
                        ],
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'If I had a program like that as a freshman my experiences would have been much different!',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 14.0, height: 1.2),
                          ),
                        ),
                      ),
                      Stack(alignment: Alignment.center, children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.reply,
                              size: 20,
                            ),
                            Text('Reply')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(thumbsUpCounter.toString()),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _thumbsUpColor = (thumbsup == true)
                                      ? Colors.black
                                      : const Color(0xff982F0C);
                                  _thumbsDownColor = Colors.black;
                                  thumbsDownCounter = (thumbsdown == true)
                                      ? (thumbsDownCounter - 1)
                                      : (thumbsDownCounter);
                                  thumbsup = (_thumbsUpColor == Colors.black)
                                      ? false
                                      : true;
                                  thumbsdown = false;
                                  thumbsUpCounter = (thumbsup == true)
                                      ? thumbsUpCounter += 1
                                      : thumbsUpCounter -= 1;
                                });
                              },
                              icon: Icon(
                                Icons.thumb_up,
                                color: _thumbsUpColor,
                                size: 20.0,
                              ),
                            ),
                            Text(thumbsDownCounter.toString()),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _thumbsDownColor = (thumbsdown == true)
                                      ? Colors.black
                                      : const Color(0xff982F0C);
                                  _thumbsUpColor = Colors.black;
                                  thumbsUpCounter = (thumbsup == true)
                                      ? (thumbsUpCounter - 1)
                                      : (thumbsUpCounter);
                                  thumbsdown =
                                      (_thumbsDownColor == Colors.black)
                                          ? false
                                          : true;
                                  thumbsup = false;
                                  thumbsDownCounter = (thumbsdown == true)
                                      ? thumbsDownCounter += 1
                                      : thumbsDownCounter -= 1;
                                });
                              },
                              icon: Icon(
                                Icons.thumb_down,
                                color: _thumbsDownColor,
                                size: 20.0,
                              ),
                            ),
                          ],
                        )
                      ]),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  width: 350,
                  height: 130,
                  decoration: BoxDecoration(
                      color: const Color(0xffEDEDED),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: const Color(0xffB0B0B0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          AssetImage('images/placeholder.png'),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              const Text(
                                'FirstName LastName',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: const Text(
                              '12 hours ago',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 12.0, color: Color(0xff6B6B6B)),
                            ),
                          ),
                        ],
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'I think it is a great idea for freshman who are new to campus. Great idea!',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 14.0, height: 1.2),
                          ),
                        ),
                      ),
                      Stack(alignment: Alignment.center, children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.reply,
                              size: 20,
                            ),
                            Text('Reply')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(thumbsUpCounter2.toString()),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _thumbsUpColor2 = (thumbsup2 == true)
                                      ? Colors.black
                                      : const Color(0xff982F0C);
                                  _thumbsDownColor2 = Colors.black;
                                  thumbsDownCounter2 = (thumbsdown2 == true)
                                      ? (thumbsDownCounter2 - 1)
                                      : (thumbsDownCounter2);
                                  thumbsup2 = (_thumbsUpColor2 == Colors.black)
                                      ? false
                                      : true;
                                  thumbsdown2 = false;
                                  thumbsUpCounter2 = (thumbsup2 == true)
                                      ? thumbsUpCounter2 += 1
                                      : thumbsUpCounter2 -= 1;
                                });
                              },
                              icon: Icon(
                                Icons.thumb_up,
                                color: _thumbsUpColor2,
                                size: 20.0,
                              ),
                            ),
                            Text(thumbsDownCounter2.toString()),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _thumbsDownColor2 = (thumbsdown2 == true)
                                      ? Colors.black
                                      : const Color(0xff982F0C);
                                  _thumbsUpColor2 = Colors.black;
                                  thumbsUpCounter2 = (thumbsup2 == true)
                                      ? (thumbsUpCounter2 - 1)
                                      : (thumbsUpCounter2);
                                  thumbsdown2 =
                                      (_thumbsDownColor2 == Colors.black)
                                          ? false
                                          : true;
                                  thumbsup2 = false;
                                  thumbsDownCounter2 = (thumbsdown2 == true)
                                      ? thumbsDownCounter2 += 1
                                      : thumbsDownCounter2 -= 1;
                                });
                              },
                              icon: Icon(
                                Icons.thumb_down,
                                color: _thumbsDownColor2,
                                size: 20.0,
                              ),
                            ),
                          ],
                        )
                      ]),
                    ],
                  )),
            ),
          ],
        ));

    Widget addComment = Expanded(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 75,
                decoration: BoxDecoration(
                    color: const Color(0xffEDEDED),
                    border: Border.all(color: const Color(0xffA3A3A3))),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: const Color(0xffA3A3A3))),
                    child:
                        Stack(alignment: Alignment.centerLeft, children: const [
                      Text('Add Comment...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0, color: Color(0xff6B6B6B))),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.send, size: 30.0),
                      )
                    ])))));

    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Homepage()),
              );
            },
          );
        }),
        centerTitle: true,
        toolbarHeight: 60,
        title: const Text('Discussion', style: TextStyle(fontSize: 24.0)),
        backgroundColor: const Color(0xff7D2721),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 30),
            icon: const Icon(Icons.menu, size: 40.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Menu()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          discussion,
          comments,
          addComment,
        ],
      ),
    );
  }
}

class MentorshipProgram extends StatelessWidget {
  const MentorshipProgram({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Homepage()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title: const Text('Mentorship Program',
              style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Mentorship Program for African American Boilermakers',
                        style: TextStyle(fontSize: 32.0, height: 1.3),
                      )),
                  const Text(
                    'Freshman are invited to join our mentorship program in partnership with upperclassmen and Purdue alumni.',
                    style: TextStyle(fontSize: 20.0, height: 1.3),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: Text(
                        'Benefits of Joining This Program',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 28.0, color: Color(0xff7D2721)),
                      )),
                  const Text(
                      'Freshmen are paired with an alumni or upperclassmen mentor based on their preferences and personality quiz results. The mentorship program caters to your major, personality, interests, and goals, so that your chosen mentor can enhance your Purdue experiences as much as possible. With your mentor, you can get settled into campus-life at Purdue in a way that best fits you. Join the mentorship program today to form a connection that can last a lifetime!',
                      style: TextStyle(fontSize: 20.0, height: 1.3)),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Image.asset(
                      'images/mentorship.jpg',
                      width: 300,
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Copyright \u00a9 2021 Purdue University',
                        textAlign: TextAlign.center,
                      )),
                  const Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: Text(
                        'How to Join',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 28.0, color: Color(0xff7D2721)),
                      )),
                  const Text(
                      'To get started, take our personality quiz below. You will be allowed to register after completing the quiz. You are also encouraged to check out our list of registered mentors who are ready to be paired with freshmen. Should you find an available mentor that interests you, feel free to send them a chat! Freshmen are allowed to request specific mentors when they sign up.',
                      style: TextStyle(fontSize: 20.0, height: 1.3)),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffB0B0B0)),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: SizedBox.fromSize(
                          size: const Size(100, 100),
                          child: Material(
                            color: const Color(0xffEDEDED),
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MentorSearchType()),
                                );
                              },
                              child: Column(
                                children: const <Widget>[
                                  Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.supervisor_account,
                                          size: 50)),
                                  Text(
                                    "Mentors",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffB0B0B0)),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: SizedBox.fromSize(
                          size: const Size(100, 100),
                          child: Material(
                            color: const Color(0xffEDEDED),
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: const <Widget>[
                                  Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Icon(Icons.psychology, size: 50)),
                                  Text(
                                    "Personality Quiz",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 265,
                      margin: const EdgeInsets.only(bottom: 20.0),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Color(0xffA3A3A3)))),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      style: ButtonStyle(
                        alignment: Alignment.center,
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff7D2721)),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(20.0)),
                        fixedSize: MaterialStateProperty.all(
                            const Size.fromWidth(350)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ])));
  }
}

class MentorSearchType extends StatefulWidget {
  const MentorSearchType({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MentorSearchTypeState();
  }
}

String? dropdownValue;

class _MentorSearchTypeState extends State<MentorSearchType> {
  @override
  Widget build(BuildContext context) {
    Widget dropdown = DropdownButton(
        items: <String>['Alumni', 'Student']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(fontSize: 20.0),
            ),
          );
        }).toList(),
        hint: const Text(
          'Choose a type',
          style: TextStyle(fontSize: 20.0),
        ),
        value: dropdownValue,
        icon: const Icon(
          Icons.arrow_drop_down,
          size: 24.0,
        ),
        onChanged: (String? newValue) => setState(() {
              dropdownValue = newValue ?? "";
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => (dropdownValue == 'Alumni')
                        ? const AlumniSearchIndustry()
                        : const StudentSearchMajor()),
              );
            }));

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MentorshipProgram()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title: const Text('Mentor Search', style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Mentor Type',
                    style: TextStyle(fontSize: 32.0, height: 1.3),
                  )),
              const Text(
                'Student or Alumni',
                style: TextStyle(fontSize: 20.0, height: 1.3),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: dropdown),
            ])));
  }
}

class AlumniSearchIndustry extends StatefulWidget {
  const AlumniSearchIndustry({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AlumniSearchIndustryState();
  }
}

class _AlumniSearchIndustryState extends State<AlumniSearchIndustry> {
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    Widget dropdown = DropdownButton(
        items: <String>[
          'Accounting',
          'Agriculture',
          'Arts and Design',
          'Chemistry',
          'Computer Science',
          'Education',
          'Engineering',
          'Entrepreneurship',
          'Finance',
          'Health Care',
          'Mathematics',
          'Manufacturing',
          'User Experience Design'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(fontSize: 20.0),
            ),
          );
        }).toList(),
        hint: const Text(
          'Choose an industry',
          style: TextStyle(fontSize: 20.0),
        ),
        value: dropdownValue,
        icon: const Icon(
          Icons.arrow_drop_down,
          size: 24.0,
        ),
        onChanged: (String? newValue) => setState(() {
              dropdownValue = newValue ?? "";
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        (dropdownValue == 'User Experience Design')
                            ? const AlumniSearchResults()
                            : const AlumniSearchIndustry()),
              );
            }));

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MentorSearchType()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title: const Text('Mentor Search', style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Alumni Search',
                        style: TextStyle(fontSize: 32.0, height: 1.3),
                      )),
                  const Text(
                    'Choose an industry.',
                    style: TextStyle(fontSize: 20.0, height: 1.3),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: dropdown),
                ],
              ),
            ])));
  }
}

class AlumniSearchResults extends StatefulWidget {
  const AlumniSearchResults({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AlumniSearchResultsState();
  }
}

class _AlumniSearchResultsState extends State<AlumniSearchResults> {
  String dropdownValue = 'User Experience Design';
  @override
  Widget build(BuildContext context) {
    Widget dropdown = DropdownButton(
        items: <String>[
          'Accounting',
          'Agriculture',
          'Arts and Design',
          'Chemistry',
          'Computer Science',
          'Education',
          'Engineering',
          'Entrepreneurship',
          'Finance',
          'Health Care',
          'Mathematics',
          'Manufacturing',
          'User Experience Design'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(fontSize: 20.0),
            ),
          );
        }).toList(),
        value: dropdownValue,
        icon: const Icon(
          Icons.arrow_drop_down,
          size: 24.0,
        ),
        onChanged: (String? newValue) => setState(() {
              dropdownValue = newValue ?? "";
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        (dropdownValue == 'User Experience Design')
                            ? const AlumniSearchResults()
                            : const AlumniSearchIndustry()),
              );
            }));

    Widget results = ListView(
      shrinkWrap: true,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 130,
                height: 160,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MessageAlumniPage()));
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(15),
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/profile-pic.jpg'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            "Hannah Arnett",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "UX Designer",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 130,
                height: 160,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(15),
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/placeholder.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            "Robert Smith",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Senior UX Designer",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 130,
                height: 160,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(15),
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/placeholder.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            "Eric Miller",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Project Manager",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 130,
                height: 160,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(15),
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/placeholder.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            "Mary Williams",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "UX Designer",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 130,
                height: 160,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(15),
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/placeholder.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            "Karen Garcia",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "UX Researcher",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 130,
                height: 160,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(15),
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/placeholder.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            "Bob Smith",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "UX/UI Designer",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MentorSearchType()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title: const Text('Mentor Search', style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Alumni Search',
                  style: TextStyle(fontSize: 32.0, height: 1.3),
                  textAlign: TextAlign.left,
                )),
            const Text(
              'Choose an industry.',
              style: TextStyle(fontSize: 20.0, height: 1.3),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: dropdown),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Color(0xffA3A3A3))),
                        alignment: Alignment.center,
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(5.0)),
                        fixedSize:
                            MaterialStateProperty.all(const Size.fromWidth(70)),
                      ),
                      onPressed: () {},
                      child:
                          Row(mainAxisSize: MainAxisSize.min, children: const [
                        Text(
                          'Filter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff6B6B6B),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.filter_alt,
                          size: 15.0,
                        ),
                      ]),
                    )),
                OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.center,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(100)),
                  ),
                  onPressed: () {},
                  child: Row(mainAxisSize: MainAxisSize.min, children: const [
                    Text(
                      'Sort by...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff6B6B6B),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30.0,
                    ),
                  ]),
                ),
              ],
            ),
            Expanded(
              child: results,
            ),
          ]),
        ));
  }
}

class MessageAlumniPage extends StatelessWidget {
  const MessageAlumniPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget messages = Column(children: [
      Align(
        alignment: Alignment.topRight,
        child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.only(right: 20.0, top: 20.0, bottom: 10.0),
            width: 180,
            decoration: BoxDecoration(
                color: const Color(0xffEDEDED),
                borderRadius: BorderRadius.circular(8.0)),
            child: const Text(
                'Hi! I saw that you are a UX Designer at Google and Google is my dream job! Can you give me some advice?',
                style: TextStyle(fontSize: 20.0))),
      ),
      Align(
        alignment: Alignment.topLeft,
        child: Container(
            padding: const EdgeInsets.all(20.0),
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            width: 180,
            decoration: BoxDecoration(
                color: const Color(0xffACC664),
                borderRadius: BorderRadius.circular(8.0)),
            child: const Text(
                'Hi! Google is a tough company to get into, but it is possible with a lot of preparation. I would be glad to talk to you about it.',
                style: TextStyle(fontSize: 20.0))),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Container(
            padding: const EdgeInsets.all(20.0),
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            width: 180,
            decoration: BoxDecoration(
                color: const Color(0xffEDEDED),
                borderRadius: BorderRadius.circular(8.0)),
            child: const Text(
                'That would be great! I will put your name down in my mentor request.',
                style: TextStyle(fontSize: 20.0))),
      ),
      Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.only(right: 20.0),
          child: const Text('Delivered')),
    ]);

    Widget addComment = Expanded(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 75,
                decoration: BoxDecoration(
                    color: const Color(0xffEDEDED),
                    border: Border.all(color: const Color(0xffA3A3A3))),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_a_photo, size: 30.0)),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: const Color(0xffA3A3A3))),
                    child:
                        Stack(alignment: Alignment.centerLeft, children: const [
                      Text('Text Message',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0, color: Color(0xff6B6B6B))),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.send, size: 30.0),
                      )
                    ]),
                  ))
                ]))));

    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AlumniSearchResults()),
              );
            },
          );
        }),
        centerTitle: true,
        toolbarHeight: 60,
        title: const Text('Hannah Arnett', style: TextStyle(fontSize: 24.0)),
        backgroundColor: const Color(0xff7D2721),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 30),
            icon: const Icon(Icons.menu, size: 40.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Menu()),
              );
            },
          ),
        ],
      ),
      body: Column(children: [
        messages,
        addComment,
      ]),
    );
  }
}

class StudentSearchMajor extends StatefulWidget {
  const StudentSearchMajor({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StudentSearchMajorState();
  }
}

class _StudentSearchMajorState extends State<StudentSearchMajor> {
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    Widget dropdown = DropdownButton(
        items: <String>[
          'Accounting',
          'Agriculture',
          'Arts and Design',
          'Chemistry',
          'Computer Science',
          'Education',
          'Engineering',
          'Entrepreneurship',
          'Finance',
          'Health Care',
          'Mathematics',
          'Manufacturing',
          'User Experience Design'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(fontSize: 20.0),
            ),
          );
        }).toList(),
        hint: const Text(
          'Choose a major',
          style: TextStyle(fontSize: 20.0),
        ),
        value: dropdownValue,
        icon: const Icon(
          Icons.arrow_drop_down,
          size: 24.0,
        ),
        onChanged: (String? newValue) => setState(() {
              dropdownValue = newValue ?? "";
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        (dropdownValue == 'User Experience Design')
                            ? const StudentSearchResults()
                            : const StudentSearchMajor()),
              );
            }));

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MentorSearchType()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title: const Text('Mentor Search', style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Student Search',
                        style: TextStyle(fontSize: 32.0, height: 1.3),
                      )),
                  const Text(
                    'Choose a major.',
                    style: TextStyle(fontSize: 20.0, height: 1.3),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: dropdown),
                ],
              ),
            ])));
  }
}

class StudentSearchResults extends StatefulWidget {
  const StudentSearchResults({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StudentSearchResultsState();
  }
}

class _StudentSearchResultsState extends State<StudentSearchResults> {
  String dropdownValue = 'User Experience Design';
  @override
  Widget build(BuildContext context) {
    Widget dropdown = DropdownButton(
        items: <String>[
          'Accounting',
          'Agriculture',
          'Arts and Design',
          'Chemistry',
          'Computer Science',
          'Education',
          'Engineering',
          'Entrepreneurship',
          'Finance',
          'Health Care',
          'Mathematics',
          'Manufacturing',
          'User Experience Design'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(fontSize: 20.0),
            ),
          );
        }).toList(),
        value: dropdownValue,
        icon: const Icon(
          Icons.arrow_drop_down,
          size: 24.0,
        ),
        onChanged: (String? newValue) => setState(() {
              dropdownValue = newValue ?? "";
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        (dropdownValue == 'User Experience Design')
                            ? const AlumniSearchResults()
                            : const AlumniSearchIndustry()),
              );
            }));

    Widget results = ListView(
      shrinkWrap: true,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 130,
                height: 160,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MessageStudentPage()),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(15),
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/profile-pic.jpg'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            "Hannah Arnett",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Senior",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 130,
                height: 160,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(15),
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/placeholder.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            "Jason Miller",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Senior",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 130,
                height: 160,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(15),
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/placeholder.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            "Jessica Jones",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Junior",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 130,
                height: 160,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(15),
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/placeholder.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            "Mike Johnson",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Senior",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 130,
                height: 160,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(15),
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/placeholder.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            "Kenzie Smith",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Senior",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 130,
                height: 160,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(15),
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/placeholder.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            "Kelly Sanders",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Junior",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MentorSearchType()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title: const Text('Mentor Search', style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Student Search',
                  style: TextStyle(fontSize: 32.0, height: 1.3),
                  textAlign: TextAlign.left,
                )),
            const Text(
              'Choose a major.',
              style: TextStyle(fontSize: 20.0, height: 1.3),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: dropdown),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Color(0xffA3A3A3))),
                        alignment: Alignment.center,
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(5.0)),
                        fixedSize:
                            MaterialStateProperty.all(const Size.fromWidth(70)),
                      ),
                      onPressed: () {},
                      child:
                          Row(mainAxisSize: MainAxisSize.min, children: const [
                        Text(
                          'Filter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff6B6B6B),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.filter_alt,
                          size: 15.0,
                        ),
                      ]),
                    )),
                OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.center,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(100)),
                  ),
                  onPressed: () {},
                  child: Row(mainAxisSize: MainAxisSize.min, children: const [
                    Text(
                      'Sort by...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff6B6B6B),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30.0,
                    ),
                  ]),
                ),
              ],
            ),
            Expanded(
              child: results,
            ),
          ]),
        ));
  }
}

class MessageStudentPage extends StatelessWidget {
  const MessageStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget messages = Column(children: [
      Align(
        alignment: Alignment.topRight,
        child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.only(right: 20.0, top: 20.0, bottom: 10.0),
            width: 180,
            decoration: BoxDecoration(
                color: const Color(0xffEDEDED),
                borderRadius: BorderRadius.circular(8.0)),
            child: const Text(
                'Hi! I am also in UX Design! Do you want to be my mentor?',
                style: TextStyle(fontSize: 20.0))),
      ),
      Align(
        alignment: Alignment.topLeft,
        child: Container(
            padding: const EdgeInsets.all(20.0),
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            width: 180,
            decoration: BoxDecoration(
                color: const Color(0xffACC664),
                borderRadius: BorderRadius.circular(8.0)),
            child: const Text('Hi! I would love to!',
                style: TextStyle(fontSize: 20.0))),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Container(
            padding: const EdgeInsets.all(20.0),
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            width: 180,
            decoration: BoxDecoration(
                color: const Color(0xffEDEDED),
                borderRadius: BorderRadius.circular(8.0)),
            child: const Text(
                'Awesome! I will request you as my mentor when I sign up. Do you want to meet sometime soon?',
                style: TextStyle(fontSize: 20.0))),
      ),
      Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.only(right: 20.0),
          child: const Text('Delivered')),
    ]);

    Widget addComment = Expanded(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 75,
                decoration: BoxDecoration(
                    color: const Color(0xffEDEDED),
                    border: Border.all(color: const Color(0xffA3A3A3))),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_a_photo, size: 30.0)),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: const Color(0xffA3A3A3))),
                    child:
                        Stack(alignment: Alignment.centerLeft, children: const [
                      Text('Text Message',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0, color: Color(0xff6B6B6B))),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.send, size: 30.0),
                      )
                    ]),
                  ))
                ]))));

    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StudentSearchResults()),
              );
            },
          );
        }),
        centerTitle: true,
        toolbarHeight: 60,
        title: const Text('Hannah Arnett', style: TextStyle(fontSize: 24.0)),
        backgroundColor: const Color(0xff7D2721),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 30),
            icon: const Icon(Icons.menu, size: 40.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Menu()),
              );
            },
          ),
        ],
      ),
      body: Column(children: [
        messages,
        addComment,
      ]),
    );
  }
}

class ResourceCategories extends StatelessWidget {
  const ResourceCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Homepage()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title: const Text('Resource Categories',
              style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BrowseAcademics()),
                          );
                        },
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          side: MaterialStateProperty.all(
                              const BorderSide(color: Color(0xffA3A3A3))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffEDEDED)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 15.0)),
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(350)),
                        ),
                        icon: const Icon(
                          Icons.school,
                          color: Colors.black,
                          size: 40.0,
                        ),
                        label: const Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Academics',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 30.0),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BrowseFitness()),
                          );
                        },
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          side: MaterialStateProperty.all(
                              const BorderSide(color: Color(0xffA3A3A3))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffEDEDED)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 15.0)),
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(350)),
                        ),
                        icon: const Icon(
                          Icons.fitness_center,
                          color: Colors.black,
                          size: 40.0,
                        ),
                        label: const Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Fitness',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 30.0),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BrowseFood()),
                          );
                        },
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          side: MaterialStateProperty.all(
                              const BorderSide(color: Color(0xffA3A3A3))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffEDEDED)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 15.0)),
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(350)),
                        ),
                        icon: const Icon(
                          Icons.fastfood,
                          color: Colors.black,
                          size: 40.0,
                        ),
                        label: const Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Food',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 30.0),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BrowseHobbies()),
                          );
                        },
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          side: MaterialStateProperty.all(
                              const BorderSide(color: Color(0xffA3A3A3))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffEDEDED)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 15.0)),
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(350)),
                        ),
                        icon: const Icon(
                          Icons.sports_esports,
                          color: Colors.black,
                          size: 40.0,
                        ),
                        label: const Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Hobbies',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 30.0),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BrowsePersonalCare()),
                          );
                        },
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          side: MaterialStateProperty.all(
                              const BorderSide(color: Color(0xffA3A3A3))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffEDEDED)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 15.0)),
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(350)),
                        ),
                        icon: const Icon(
                          Icons.face_retouching_natural,
                          color: Colors.black,
                          size: 40.0,
                        ),
                        label: const Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Personal Care',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 30.0),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BrowsePrograms()),
                          );
                        },
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          side: MaterialStateProperty.all(
                              const BorderSide(color: Color(0xffA3A3A3))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffEDEDED)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 15.0)),
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(350)),
                        ),
                        icon: const Icon(
                          Icons.groups,
                          color: Colors.black,
                          size: 40.0,
                        ),
                        label: const Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Purdue Programs',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 30.0),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BrowseReligious()),
                          );
                        },
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          side: MaterialStateProperty.all(
                              const BorderSide(color: Color(0xffA3A3A3))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffEDEDED)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 15.0)),
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(350)),
                        ),
                        icon: const Icon(
                          Icons.menu_book,
                          color: Colors.black,
                          size: 40.0,
                        ),
                        label: const Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Religious',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 30.0),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BrowseServices()),
                          );
                        },
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          side: MaterialStateProperty.all(
                              const BorderSide(color: Color(0xffA3A3A3))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffEDEDED)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 15.0)),
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(350)),
                        ),
                        icon: const Icon(
                          Icons.handshake,
                          color: Colors.black,
                          size: 40.0,
                        ),
                        label: const Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Services',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 30.0),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BrowseShopping()),
                          );
                        },
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          side: MaterialStateProperty.all(
                              const BorderSide(color: Color(0xffA3A3A3))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffEDEDED)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 15.0)),
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(350)),
                        ),
                        icon: const Icon(
                          Icons.shopping_basket,
                          color: Colors.black,
                          size: 40.0,
                        ),
                        label: const Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Shopping',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 30.0),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BrowseSocial()),
                          );
                        },
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          side: MaterialStateProperty.all(
                              const BorderSide(color: Color(0xffA3A3A3))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffEDEDED)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 15.0)),
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(350)),
                        ),
                        icon: const Icon(
                          Icons.messenger,
                          color: Colors.black,
                          size: 40.0,
                        ),
                        label: const Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Social',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 30.0),
                            ))),
                  )
                ],
              )
            ])));
  }
}

class BrowseAcademics extends StatelessWidget {
  const BrowseAcademics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget stores = ListView(
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/bcc.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Black Cultural Center Library",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(Icons.near_me, size: 10.0),
                                Text('0.9 Mi Away'),
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/bcc.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Black Cultural Center",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(Icons.near_me, size: 10.0),
                                Text('0.9 Mi Away'),
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResourceCategories()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title:
              const Text('Browse Academics', style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: OutlinedButton.icon(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.centerLeft,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffEDEDED)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(220)),
                  ),
                  onPressed: () {},
                  label: const Text(
                    'Search...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff6B6B6B),
                    ),
                  ),
                  icon: const Icon(
                    Icons.search,
                    size: 30.0,
                    color: Color(0xff6B6B6B),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Color(0xffA3A3A3))),
                        alignment: Alignment.center,
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(5.0)),
                        fixedSize:
                            MaterialStateProperty.all(const Size.fromWidth(70)),
                      ),
                      onPressed: () {},
                      child:
                          Row(mainAxisSize: MainAxisSize.min, children: const [
                        Text(
                          'Filter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff6B6B6B),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.filter_alt,
                          size: 15.0,
                        ),
                      ]),
                    )),
                OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.center,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(100)),
                  ),
                  onPressed: () {},
                  child: Row(mainAxisSize: MainAxisSize.min, children: const [
                    Text(
                      'Sort by...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff6B6B6B),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30.0,
                    ),
                  ]),
                ),
              ],
            ),
            Expanded(
              child: stores,
            ),
          ]),
        ));
  }
}

class BrowseFitness extends StatelessWidget {
  const BrowseFitness({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget stores = ListView(
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/corec.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "France A. Córdova Recreational Sports Center",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(Icons.near_me, size: 10.0),
                                Text('1.1 Mi Away'),
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/glowflowyoga.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "The Glow Flow Yoga",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('Lafayette, IN'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '5.0',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResourceCategories()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title: const Text('Browse Fitness', style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: OutlinedButton.icon(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.centerLeft,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffEDEDED)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(220)),
                  ),
                  onPressed: () {},
                  label: const Text(
                    'Search...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff6B6B6B),
                    ),
                  ),
                  icon: const Icon(
                    Icons.search,
                    size: 30.0,
                    color: Color(0xff6B6B6B),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Color(0xffA3A3A3))),
                        alignment: Alignment.center,
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(5.0)),
                        fixedSize:
                            MaterialStateProperty.all(const Size.fromWidth(70)),
                      ),
                      onPressed: () {},
                      child:
                          Row(mainAxisSize: MainAxisSize.min, children: const [
                        Text(
                          'Filter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff6B6B6B),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.filter_alt,
                          size: 15.0,
                        ),
                      ]),
                    )),
                OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.center,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(100)),
                  ),
                  onPressed: () {},
                  child: Row(mainAxisSize: MainAxisSize.min, children: const [
                    Text(
                      'Sort by...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff6B6B6B),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30.0,
                    ),
                  ]),
                ),
              ],
            ),
            Expanded(
              child: stores,
            ),
          ]),
        ));
  }
}

class BrowseFood extends StatelessWidget {
  const BrowseFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget stores = ListView(
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/tastechicago.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Tastes of Chicago",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('3.4 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '3.0',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/fazolis.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Fazoli's",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('3.5 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '5.0',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/elliscatering.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Ellis Catering",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('Lafayette, IN'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      'N/A',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/ford.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Ford Dining Court",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('0.8 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '4.2',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/hillenbrand.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Hillenbrand Dining Court",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('1.3 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '4.2',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/wiley.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Wiley Dining Court",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('1.4 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '4.2',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/earhart.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Earhart Dining Court",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('1.0 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '4.3',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/kennyspopcorn.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Kenny Kendall's Gourmet Popcorn",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('8.9 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '4.9',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResourceCategories()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title: const Text('Browse Food', style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: OutlinedButton.icon(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.centerLeft,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffEDEDED)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(220)),
                  ),
                  onPressed: () {},
                  label: const Text(
                    'Search...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff6B6B6B),
                    ),
                  ),
                  icon: const Icon(
                    Icons.search,
                    size: 30.0,
                    color: Color(0xff6B6B6B),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Color(0xffA3A3A3))),
                        alignment: Alignment.center,
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(5.0)),
                        fixedSize:
                            MaterialStateProperty.all(const Size.fromWidth(70)),
                      ),
                      onPressed: () {},
                      child:
                          Row(mainAxisSize: MainAxisSize.min, children: const [
                        Text(
                          'Filter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff6B6B6B),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.filter_alt,
                          size: 15.0,
                        ),
                      ]),
                    )),
                OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.center,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(100)),
                  ),
                  onPressed: () {},
                  child: Row(mainAxisSize: MainAxisSize.min, children: const [
                    Text(
                      'Sort by...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff6B6B6B),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30.0,
                    ),
                  ]),
                ),
              ],
            ),
            Expanded(
              child: stores,
            ),
          ]),
        ));
  }
}

class BrowseHobbies extends StatelessWidget {
  const BrowseHobbies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget stores = ListView(shrinkWrap: true, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: 170,
              height: 210,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffB0B0B0)),
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(8.0)),
              child: SizedBox.fromSize(
                child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {},
                    child: Column(children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                        width: 140,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          shape: BoxShape.rectangle,
                          image: const DecorationImage(
                              image: AssetImage('images/dboygeniustattoo.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "DBoyGenius tattoos",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                "Open Now",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0, color: Color(0xff495E1C)),
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.near_me, size: 10.0),
                                  Text('Lafayette, IN'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    '5.0',
                                    textAlign: TextAlign.right,
                                  ),
                                  Icon(Icons.star, color: Color(0xffF2CF73))
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: 170,
              height: 210,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffB0B0B0)),
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(8.0)),
              child: SizedBox.fromSize(
                child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {},
                    child: Column(children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                        width: 140,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          shape: BoxShape.rectangle,
                          image: const DecorationImage(
                              image: AssetImage('images/glowflowyoga.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "The Glow Flow Yoga",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                "Open Now",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0, color: Color(0xff495E1C)),
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.near_me, size: 10.0),
                                  Text('Lafayette, IN'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    '5.0',
                                    textAlign: TextAlign.right,
                                  ),
                                  Icon(Icons.star, color: Color(0xffF2CF73))
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    ]);

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResourceCategories()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title: const Text('Browse Hobbies', style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: OutlinedButton.icon(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.centerLeft,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffEDEDED)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(220)),
                  ),
                  onPressed: () {},
                  label: const Text(
                    'Search...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff6B6B6B),
                    ),
                  ),
                  icon: const Icon(
                    Icons.search,
                    size: 30.0,
                    color: Color(0xff6B6B6B),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Color(0xffA3A3A3))),
                        alignment: Alignment.center,
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(5.0)),
                        fixedSize:
                            MaterialStateProperty.all(const Size.fromWidth(70)),
                      ),
                      onPressed: () {},
                      child:
                          Row(mainAxisSize: MainAxisSize.min, children: const [
                        Text(
                          'Filter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff6B6B6B),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.filter_alt,
                          size: 15.0,
                        ),
                      ]),
                    )),
                OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.center,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(100)),
                  ),
                  onPressed: () {},
                  child: Row(mainAxisSize: MainAxisSize.min, children: const [
                    Text(
                      'Sort by...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff6B6B6B),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30.0,
                    ),
                  ]),
                ),
              ],
            ),
            Expanded(
              child: stores,
            ),
          ]),
        ));
  }
}

class BrowsePersonalCare extends StatelessWidget {
  const BrowsePersonalCare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget stores = ListView(shrinkWrap: true, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: 170,
              height: 210,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffB0B0B0)),
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(8.0)),
              child: SizedBox.fromSize(
                child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {},
                    child: Column(children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                        width: 140,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          shape: BoxShape.rectangle,
                          image: const DecorationImage(
                              image: AssetImage('images/roccosbarbershop.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Rocco's Barbershop",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                "Closed",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0, color: Color(0xff982F0C)),
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.near_me, size: 10.0),
                                  Text('1.4 Mi Away'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    '4.8',
                                    textAlign: TextAlign.right,
                                  ),
                                  Icon(Icons.star, color: Color(0xffF2CF73))
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: 170,
              height: 210,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffB0B0B0)),
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(8.0)),
              child: SizedBox.fromSize(
                child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {},
                    child: Column(children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                        width: 140,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          shape: BoxShape.rectangle,
                          image: const DecorationImage(
                              image: AssetImage('images/jclarkbarbershop.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "J Clark's Barbershop",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                "Open Now",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0, color: Color(0xff495E1C)),
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.near_me, size: 10.0),
                                  Text('3.5 Mi Away'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    '4.3',
                                    textAlign: TextAlign.right,
                                  ),
                                  Icon(Icons.star, color: Color(0xffF2CF73))
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: 170,
              height: 210,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffB0B0B0)),
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(8.0)),
              child: SizedBox.fromSize(
                child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {},
                    child: Column(children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                        width: 140,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          shape: BoxShape.rectangle,
                          image: const DecorationImage(
                              image: AssetImage('images/fellasbarbershop.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Fella's Barbershop",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                "Open Now",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0, color: Color(0xff495E1C)),
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.near_me, size: 10.0),
                                  Text('3.1 Mi Away'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    '4.1',
                                    textAlign: TextAlign.right,
                                  ),
                                  Icon(Icons.star, color: Color(0xffF2CF73))
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: 170,
              height: 210,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffB0B0B0)),
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(8.0)),
              child: SizedBox.fromSize(
                child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {},
                    child: Column(children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                        width: 140,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          shape: BoxShape.rectangle,
                          image: const DecorationImage(
                              image: AssetImage('images/sphynxstudio.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "The Sphynx Waxing Studio",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                "Open Now",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0, color: Color(0xff495E1C)),
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.near_me, size: 10.0),
                                  Text('3.5 Mi Away'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    '4.9',
                                    textAlign: TextAlign.right,
                                  ),
                                  Icon(Icons.star, color: Color(0xffF2CF73))
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: 170,
              height: 210,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffB0B0B0)),
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(8.0)),
              child: SizedBox.fromSize(
                child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {},
                    child: Column(children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                        width: 140,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          shape: BoxShape.rectangle,
                          image: const DecorationImage(
                              image:
                                  AssetImage('images/naptruehairboutique.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Naptruehair Boutique",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                "Open Now",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0, color: Color(0xff495E1C)),
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.near_me, size: 10.0),
                                  Text('Lafayette, IN'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    '5.0',
                                    textAlign: TextAlign.right,
                                  ),
                                  Icon(Icons.star, color: Color(0xffF2CF73))
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: 170,
              height: 210,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffB0B0B0)),
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(8.0)),
              child: SizedBox.fromSize(
                child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {},
                    child: Column(children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                        width: 140,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          shape: BoxShape.rectangle,
                          image: const DecorationImage(
                              image: AssetImage(
                                  'images/naturallybeautifulstudio.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Naturally Beautiful Studio",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                "Open Now",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0, color: Color(0xff495E1C)),
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.near_me, size: 10.0),
                                  Text('3.4 Mi Away'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    '4.7',
                                    textAlign: TextAlign.right,
                                  ),
                                  Icon(Icons.star, color: Color(0xffF2CF73))
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    ]);

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResourceCategories()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title: const Text('Browse Personal Care',
              style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: OutlinedButton.icon(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.centerLeft,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffEDEDED)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(220)),
                  ),
                  onPressed: () {},
                  label: const Text(
                    'Search...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff6B6B6B),
                    ),
                  ),
                  icon: const Icon(
                    Icons.search,
                    size: 30.0,
                    color: Color(0xff6B6B6B),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Color(0xffA3A3A3))),
                        alignment: Alignment.center,
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(5.0)),
                        fixedSize:
                            MaterialStateProperty.all(const Size.fromWidth(70)),
                      ),
                      onPressed: () {},
                      child:
                          Row(mainAxisSize: MainAxisSize.min, children: const [
                        Text(
                          'Filter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff6B6B6B),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.filter_alt,
                          size: 15.0,
                        ),
                      ]),
                    )),
                OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.center,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(100)),
                  ),
                  onPressed: () {},
                  child: Row(mainAxisSize: MainAxisSize.min, children: const [
                    Text(
                      'Sort by...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff6B6B6B),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30.0,
                    ),
                  ]),
                ),
              ],
            ),
            Expanded(
              child: stores,
            ),
          ]),
        ));
  }
}

class BrowsePrograms extends StatelessWidget {
  const BrowsePrograms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget stores = ListView(
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 190,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/bgr.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: const [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Boiler Gold Rush",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Orientation and Transition",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Student Success Programs",
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 190,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/horizons.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: const [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Horizons",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Student Support Services",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "A Trio Program",
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 190,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/purdue-promise.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: const [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Purdue Promise",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Student Success Programs",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 190,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/success-center.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: const [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Academic Success Center",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Student Success Programs",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 190,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/lsamp.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: const [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Louis Stokes Alliance for Minority Participation",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Office of Graduate Diversity Initiatives",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 10.0),
                              ),
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 190,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image:
                                    AssetImage('images/boiler-inclusion.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: const [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Boiler Inclusion Project",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Office of Diversity, Inclusion, and Belonging",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResourceCategories()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title:
              const Text('Browse Programs', style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: OutlinedButton.icon(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.centerLeft,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffEDEDED)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(220)),
                  ),
                  onPressed: () {},
                  label: const Text(
                    'Search...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff6B6B6B),
                    ),
                  ),
                  icon: const Icon(
                    Icons.search,
                    size: 30.0,
                    color: Color(0xff6B6B6B),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Color(0xffA3A3A3))),
                        alignment: Alignment.center,
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(5.0)),
                        fixedSize:
                            MaterialStateProperty.all(const Size.fromWidth(70)),
                      ),
                      onPressed: () {},
                      child:
                          Row(mainAxisSize: MainAxisSize.min, children: const [
                        Text(
                          'Filter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff6B6B6B),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.filter_alt,
                          size: 15.0,
                        ),
                      ]),
                    )),
                OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.center,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(100)),
                  ),
                  onPressed: () {},
                  child: Row(mainAxisSize: MainAxisSize.min, children: const [
                    Text(
                      'Sort by...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff6B6B6B),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30.0,
                    ),
                  ]),
                ),
              ],
            ),
            Expanded(
              child: stores,
            ),
          ]),
        ));
  }
}

class BrowseReligious extends StatelessWidget {
  const BrowseReligious({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget stores = ListView(
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/bethelamechurch.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Bethel AME Church",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Closed",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff982F0C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('1.8 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '5.0',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage(
                                    'images/universaldeliverance.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Universal Deliverance Church of God in Christ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Closed",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff982F0C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('2.6 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      'N/A',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image:
                                    AssetImage('images/wholetruthchurch.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Whole Truth Church",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Closed",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff982F0C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('2.8 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '4.8',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image:
                                    AssetImage('images/lafayettemission.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: const [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Lafayette Mission",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Student Organization",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResourceCategories()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title:
              const Text('Browse Religious', style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: OutlinedButton.icon(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.centerLeft,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffEDEDED)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(220)),
                  ),
                  onPressed: () {},
                  label: const Text(
                    'Search...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff6B6B6B),
                    ),
                  ),
                  icon: const Icon(
                    Icons.search,
                    size: 30.0,
                    color: Color(0xff6B6B6B),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Color(0xffA3A3A3))),
                        alignment: Alignment.center,
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(5.0)),
                        fixedSize:
                            MaterialStateProperty.all(const Size.fromWidth(70)),
                      ),
                      onPressed: () {},
                      child:
                          Row(mainAxisSize: MainAxisSize.min, children: const [
                        Text(
                          'Filter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff6B6B6B),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.filter_alt,
                          size: 15.0,
                        ),
                      ]),
                    )),
                OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.center,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(100)),
                  ),
                  onPressed: () {},
                  child: Row(mainAxisSize: MainAxisSize.min, children: const [
                    Text(
                      'Sort by...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff6B6B6B),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30.0,
                    ),
                  ]),
                ),
              ],
            ),
            Expanded(
              child: stores,
            ),
          ]),
        ));
  }
}

class BrowseServices extends StatelessWidget {
  const BrowseServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget stores = ListView(
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/kyreestinting.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Kyree's Window Tinting & Films",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Closed",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff982F0C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('4.0 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '5.0',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/chardebarrett.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Chardé Barrett Photography",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('3.5 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '5.0',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/elliscatering.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Ellis Catering",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('Lafayette, IN'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      'N/A',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image:
                                    AssetImage('images/roccosbarbershop.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Rocco's Barbershop",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Closed",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff982F0C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('1.4 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '4.8',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResourceCategories()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title:
              const Text('Browse Services', style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: OutlinedButton.icon(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.centerLeft,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffEDEDED)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(220)),
                  ),
                  onPressed: () {},
                  label: const Text(
                    'Search...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff6B6B6B),
                    ),
                  ),
                  icon: const Icon(
                    Icons.search,
                    size: 30.0,
                    color: Color(0xff6B6B6B),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Color(0xffA3A3A3))),
                        alignment: Alignment.center,
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(5.0)),
                        fixedSize:
                            MaterialStateProperty.all(const Size.fromWidth(70)),
                      ),
                      onPressed: () {},
                      child:
                          Row(mainAxisSize: MainAxisSize.min, children: const [
                        Text(
                          'Filter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff6B6B6B),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.filter_alt,
                          size: 15.0,
                        ),
                      ]),
                    )),
                OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.center,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(100)),
                  ),
                  onPressed: () {},
                  child: Row(mainAxisSize: MainAxisSize.min, children: const [
                    Text(
                      'Sort by...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff6B6B6B),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30.0,
                    ),
                  ]),
                ),
              ],
            ),
            Expanded(
              child: stores,
            ),
          ]),
        ));
  }
}

class BrowseShopping extends StatelessWidget {
  const BrowseShopping({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget stores = ListView(
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/201boutique.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "201 Boutique",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Closed",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff982F0C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('4.5 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '5.0',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/culturebox.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "The Culture Boxx LLC",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('3.9 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '5.0',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage(
                                    'images/chiffonbeautysupply.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Chiffion Beauty Supply",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('4.0 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '4.1',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StoreExample()),
                        );
                      },
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/walmart.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Walmart Supercenter",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('3.5 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '4.1',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/walmart.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Walmart Supercenter",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('4.9 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '3.9',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/target.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Target",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('0.4 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '4.3',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/lafayette-sound.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Lafayette Sound",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('1.4 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      'N/A',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 170,
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                  child: Material(
                    color: const Color(0xffEDEDED),
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/target2.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Target",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Open Now",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Color(0xff495E1C)),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.near_me, size: 10.0),
                                    Text('4.0 Mi Away'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '4.4',
                                      textAlign: TextAlign.right,
                                    ),
                                    Icon(Icons.star, color: Color(0xffF2CF73))
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResourceCategories()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title:
              const Text('Browse Shopping', style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: OutlinedButton.icon(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.centerLeft,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffEDEDED)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(220)),
                  ),
                  onPressed: () {},
                  label: const Text(
                    'Search...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff6B6B6B),
                    ),
                  ),
                  icon: const Icon(
                    Icons.search,
                    size: 30.0,
                    color: Color(0xff6B6B6B),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Color(0xffA3A3A3))),
                        alignment: Alignment.center,
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(5.0)),
                        fixedSize:
                            MaterialStateProperty.all(const Size.fromWidth(70)),
                      ),
                      onPressed: () {},
                      child:
                          Row(mainAxisSize: MainAxisSize.min, children: const [
                        Text(
                          'Filter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff6B6B6B),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.filter_alt,
                          size: 15.0,
                        ),
                      ]),
                    )),
                OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.center,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(100)),
                  ),
                  onPressed: () {},
                  child: Row(mainAxisSize: MainAxisSize.min, children: const [
                    Text(
                      'Sort by...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff6B6B6B),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30.0,
                    ),
                  ]),
                ),
              ],
            ),
            Expanded(
              child: stores,
            ),
          ]),
        ));
  }
}

class BrowseSocial extends StatelessWidget {
  const BrowseSocial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget stores = ListView(
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 170,
                height: 190,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                    child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrgExample()),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: 170,
                            height: 30,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: const Text('ORGANIZATION',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0)),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xffA3A3A3))),
                                color: Color(0xffD8D8D8))),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image:
                                    AssetImage('images/blackstudentunion.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "Black Student Union",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: const [
                                Icon(Icons.groups),
                                Text(' 139 Members',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 16.0)),
                              ],
                            ))
                      ],
                    ),
                  ),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 170,
                height: 190,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                    child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: 170,
                            height: 30,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: const Text('ORGANIZATION',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0)),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xffA3A3A3))),
                                color: Color(0xffD8D8D8))),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/nsbe.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "National Society of Black Engineers",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: const [
                                Icon(Icons.groups),
                                Text(' 82 Members',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 16.0)),
                              ],
                            ))
                      ],
                    ),
                  ),
                )),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 170,
                height: 190,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                    child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: 170,
                            height: 30,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: const Text('ORGANIZATION',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0)),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xffA3A3A3))),
                                color: Color(0xffD8D8D8))),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage(
                                    'images/africanstudentassociation.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "African Students' Association",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: const [
                                Icon(Icons.groups),
                                Text(' 88 Members',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 16.0)),
                              ],
                            ))
                      ],
                    ),
                  ),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 170,
                height: 190,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                    child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: 170,
                            height: 30,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: const Text('SORORITY',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0)),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xffA3A3A3))),
                                color: Color(0xffD8D8D8))),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/alphakappaalpha.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "Alpha Kappa Alpha Sorority, Inc.",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: const [
                                Icon(Icons.groups),
                                Text(' 13 Members',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 16.0)),
                              ],
                            ))
                      ],
                    ),
                  ),
                )),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 170,
                height: 190,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                    child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EventMovieNight()),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: 170,
                            height: 30,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: const Text('EVENT',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0)),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xffA3A3A3))),
                                color: Color(0xffD8D8D8))),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: const [
                              Text(
                                '28',
                                style: TextStyle(fontSize: 40.0),
                              ),
                              Text(
                                ' May',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.end,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Movie Night at BCC",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Text('9 PM',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text('Black Cultural Center',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 170,
                height: 190,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                    child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EventCommencement()),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: 170,
                            height: 30,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: const Text('EVENT',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0)),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xffA3A3A3))),
                                color: Color(0xffD8D8D8))),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: const [
                              Text(
                                '15',
                                style: TextStyle(fontSize: 40.0),
                              ),
                              Text(
                                ' May',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.end,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "2022 Spring Commencement",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Text('2-5 PM',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text('Elliott Hall of Music',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 170,
                height: 190,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                    child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EventGreekLife()),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: 170,
                            height: 30,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: const Text('EVENT',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0)),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xffA3A3A3))),
                                color: Color(0xffD8D8D8))),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: const [
                              Text(
                                '08',
                                style: TextStyle(fontSize: 40.0),
                              ),
                              Text(
                                ' April',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.end,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Greek Life Farewell Dinner",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Text('6-9 PM',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text('BLACK FRATERNITY',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 170,
                height: 190,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                    child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: 170,
                            height: 30,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: const Text('ORGANIZATION',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0)),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xffA3A3A3))),
                                color: Color(0xffD8D8D8))),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/bcc.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "Black Cultural Center",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: const [
                                Icon(Icons.groups),
                                Text(' 21 Members',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 16.0)),
                              ],
                            ))
                      ],
                    ),
                  ),
                )),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 170,
                height: 190,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                    child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: 170,
                            height: 30,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: const Text('ORGANIZATION',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0)),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xffA3A3A3))),
                                color: Color(0xffD8D8D8))),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                                image: AssetImage('images/bcc.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "Black Voices of Inspiration",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: const [
                                Icon(Icons.groups),
                                Text(' N/A Members',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 16.0)),
                              ],
                            ))
                      ],
                    ),
                  ),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 170,
                height: 190,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB0B0B0)),
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox.fromSize(
                    child: Material(
                  color: const Color(0xffEDEDED),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: 170,
                            height: 30,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: const Text('EVENT',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0)),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xffA3A3A3))),
                                color: Color(0xffD8D8D8))),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: const [
                              Text(
                                '03',
                                style: TextStyle(fontSize: 40.0),
                              ),
                              Text(
                                ' May',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.end,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "MANRRS General Body Meetings",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Text('6-7 PM',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text('Black Cultural Center',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResourceCategories()),
                );
              },
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title: const Text('Browse Social', style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              tooltip: 'Open menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: OutlinedButton.icon(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.centerLeft,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffEDEDED)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(220)),
                  ),
                  onPressed: () {},
                  label: const Text(
                    'Search...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff6B6B6B),
                    ),
                  ),
                  icon: const Icon(
                    Icons.search,
                    size: 30.0,
                    color: Color(0xff6B6B6B),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Color(0xffA3A3A3))),
                        alignment: Alignment.center,
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(5.0)),
                        fixedSize:
                            MaterialStateProperty.all(const Size.fromWidth(70)),
                      ),
                      onPressed: () {},
                      child:
                          Row(mainAxisSize: MainAxisSize.min, children: const [
                        Text(
                          'Filter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff6B6B6B),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.filter_alt,
                          size: 15.0,
                        ),
                      ]),
                    )),
                OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Color(0xffA3A3A3))),
                    alignment: Alignment.center,
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(100)),
                  ),
                  onPressed: () {},
                  child: Row(mainAxisSize: MainAxisSize.min, children: const [
                    Text(
                      'Sort by...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff6B6B6B),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30.0,
                    ),
                  ]),
                ),
              ],
            ),
            Expanded(
              child: stores,
            ),
          ]),
        ));
  }
}

class OrgExample extends StatefulWidget {
  const OrgExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OrgExampleState();
  }
}

class _OrgExampleState extends State<OrgExample> {
  _launchFacebook() async {
    final facebook = Uri.parse("https://www.facebook.com/purduebsu");
    if (!await launchUrl(facebook)) {
      throw 'Could not launch URL';
    }
  }

  _launchInstagram() async {
    final facebook = Uri.parse("https://www.instagram.com/purduebsu/");
    if (!await launchUrl(facebook)) {
      throw 'Could not launch URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(220.0),
            child: Stack(children: [
              AppBar(
                leading: Align(
                  alignment: Alignment.topLeft,
                  child: Builder(builder: (BuildContext context) {
                    return BackButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BrowseSocial()),
                        );
                      },
                    );
                  }),
                ),
                toolbarHeight: 60,
                centerTitle: true,
                title: const Text(
                  'Black Student Union',
                  style: TextStyle(fontSize: 30.0),
                ),
                backgroundColor: const Color(0xff7D2721),
                actions: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      padding: const EdgeInsets.only(right: 30),
                      icon: const Icon(Icons.menu, size: 40.0),
                      tooltip: 'Open menu',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Menu()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  alignment: Alignment.bottomCenter,
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.25),
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(8.0),
                    shape: BoxShape.rectangle,
                    image: const DecorationImage(
                        image: AssetImage('images/blackstudentunion.png'),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ])),
        body: ListView(children: [
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 15.0)),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffF2CF73)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        child: const Text('Academic',
                            style: TextStyle(fontSize: 20.0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BrowseAcademics()),
                          );
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 15.0)),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffF2CF73)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text('Social',
                          style: TextStyle(fontSize: 20.0)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BrowseSocial()),
                        );
                      },
                    ),
                  )
                ]),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: const Text(
                      'The primary purpose is to serve as the political voice for the black student population, increase student involvement in social, academic, and political activities, promote unity among African American student organizations, and to facilitate communication between the black student population and the Purdue University administration.',
                      style: TextStyle(fontSize: 20.0, height: 1.3)),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: const Text('139',
                            style: TextStyle(fontSize: 40.0),
                            textAlign: TextAlign.left),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text('Members',
                            style: TextStyle(fontSize: 24.0),
                            textAlign: TextAlign.left),
                      ),
                    ]),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(children: [
                        Row(children: [
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/profile-pic.jpg'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Column(children: [
                            Row(children: [
                              Container(
                                margin: const EdgeInsets.all(2.0),
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          AssetImage('images/profile-pic.jpg'),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(2.0),
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          AssetImage('images/profile-pic.jpg'),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ]),
                            Row(children: [
                              Container(
                                margin: const EdgeInsets.all(2.0),
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          AssetImage('images/profile-pic.jpg'),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(2.0),
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          AssetImage('images/profile-pic.jpg'),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ]),
                          ])
                        ]),
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text('View More',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  decoration: TextDecoration.underline),
                              textAlign: TextAlign.left),
                        ),
                      ]))
                ]),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 40.0, bottom: 10.0),
                  child: const Text('Contact Information',
                      style: TextStyle(fontSize: 30.0),
                      textAlign: TextAlign.left),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 20.0),
                  child: const Text('Email: purduebsu@gmail.com',
                      style: TextStyle(fontSize: 20.0, height: 1.3)),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 20.0),
                  child: const Text('Phone: 317-607-6316',
                      style: TextStyle(fontSize: 20.0, height: 1.3)),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: IconButton(
                        icon:
                            const FaIcon(FontAwesomeIcons.facebook, size: 40.0),
                        onPressed: _launchFacebook,
                      ),
                    ),
                    IconButton(
                      icon:
                          const FaIcon(FontAwesomeIcons.instagram, size: 40.0),
                      onPressed: _launchInstagram,
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                      top: 30.0, left: 20.0, bottom: 10.0),
                  child: const Text('Upcoming Events',
                      style: TextStyle(fontSize: 30.0),
                      textAlign: TextAlign.left),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EventMovieNight()),
                      );
                    },
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      width: 100,
                      height: 130,
                      decoration: BoxDecoration(
                          color: const Color(0xffEDEDED),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: const Color(0xffB0B0B0))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Row(
                                children: const [
                                  Text(
                                    '28',
                                    style: TextStyle(fontSize: 30.0),
                                  ),
                                  Text(
                                    'May',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.end,
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  'Movie Night at BCC',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 18.0),
                                )),
                            const Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                '9 PM',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.only(top: 20.0),
                    width: 265,
                    margin: const EdgeInsets.only(bottom: 20.0),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Color(0xffA3A3A3)))),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      style: ButtonStyle(
                        alignment: Alignment.center,
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff7D2721)),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(20.0)),
                        fixedSize: MaterialStateProperty.all(
                            const Size.fromWidth(350)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MessageGroupPage()),
                        );
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                                padding: EdgeInsets.only(right: 20.0),
                                child: Icon(Icons.chat, color: Colors.white)),
                            Text(
                              'Message Group',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                          ]),
                    )),
              ])),
        ]));
  }
}

class EventMovieNight extends StatefulWidget {
  const EventMovieNight({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EventMovieNightState();
  }
}

class _EventMovieNightState extends State<EventMovieNight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90.0),
          child: Stack(children: [
            AppBar(
              leading: Align(
                alignment: Alignment.topLeft,
                child: Builder(builder: (BuildContext context) {
                  return BackButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BrowseSocial()),
                      );
                    },
                  );
                }),
              ),
              toolbarHeight: 60,
              centerTitle: true,
              title: const Text(
                'Movie Night at BCC',
                style: TextStyle(fontSize: 30.0),
              ),
              backgroundColor: const Color(0xff7D2721),
              actions: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    padding: const EdgeInsets.only(right: 30),
                    icon: const Icon(Icons.menu, size: 40.0),
                    tooltip: 'Open menu',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Menu()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ])),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 15.0)),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xffF2CF73)),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child:
                        const Text('Hobbies', style: TextStyle(fontSize: 20.0)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BrowseHobbies()),
                      );
                    },
                  )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 15.0)),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffF2CF73)),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Text('Social', style: TextStyle(fontSize: 20.0)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BrowseSocial()),
                    );
                  },
                ),
              )
            ]),
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.only(left: 20.0, top: 40.0, bottom: 10.0),
              child: const Text('Event Information',
                  style: TextStyle(fontSize: 40.0), textAlign: TextAlign.left),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: const Text('9 PM',
                  style: TextStyle(fontSize: 24.0), textAlign: TextAlign.left),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: const Text('Black Cultural Center',
                  style: TextStyle(fontSize: 24.0), textAlign: TextAlign.left),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: const Text('May 28, 2022',
                  style: TextStyle(fontSize: 24.0), textAlign: TextAlign.left),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: const Text(
                  'The Black Student Union is hosting a movie night at the Black Cultural Center! We will be playing MOVIE TITLE 1 and MOVIE TITLE 2 back-to-back starting at 9PM. We will also be giving out snacks and drinks for anyone who RSVPs in advance!',
                  style: TextStyle(fontSize: 20.0, height: 1.3)),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: const Text('15',
                            style: TextStyle(fontSize: 40.0),
                            textAlign: TextAlign.center),
                      ),
                      const Text('Attendees',
                          style: TextStyle(fontSize: 24.0),
                          textAlign: TextAlign.center),
                      Container(
                        width: 265,
                        margin: const EdgeInsets.symmetric(vertical: 30.0),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color(0xffA3A3A3)))),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff7D2721)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20.0)),
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(350)),
                        ),
                        onPressed: () {},
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                  padding: EdgeInsets.only(right: 20.0),
                                  child: Icon(Icons.person_add,
                                      color: Colors.white)),
                              Text(
                                'Register for Event',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24.0,
                                ),
                              ),
                            ]),
                      ),
                    ]),
              ),
            ),
          ])),
    );
  }
}

class EventCommencement extends StatefulWidget {
  const EventCommencement({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EventCommencementState();
  }
}

class _EventCommencementState extends State<EventCommencement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90.0),
          child: Stack(children: [
            AppBar(
              leading: Align(
                alignment: Alignment.topLeft,
                child: Builder(builder: (BuildContext context) {
                  return BackButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BrowseSocial()),
                      );
                    },
                  );
                }),
              ),
              toolbarHeight: 60,
              centerTitle: true,
              title: const Text(
                '2022 Spring Commencement',
                style: TextStyle(fontSize: 26.0),
              ),
              backgroundColor: const Color(0xff7D2721),
              actions: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    padding: const EdgeInsets.only(right: 30),
                    icon: const Icon(Icons.menu, size: 40.0),
                    tooltip: 'Open menu',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Menu()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ])),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.only(left: 20.0, top: 40.0, bottom: 10.0),
              child: const Text('Event Information',
                  style: TextStyle(fontSize: 40.0), textAlign: TextAlign.left),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: const Text('2-5 PM',
                  style: TextStyle(fontSize: 24.0), textAlign: TextAlign.left),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: const Text('Elliott Hall of Music',
                  style: TextStyle(fontSize: 24.0), textAlign: TextAlign.left),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: const Text('May 15, 2022',
                  style: TextStyle(fontSize: 24.0), textAlign: TextAlign.left),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: const Text('Congratulations Graduating Class of 2022!',
                  style: TextStyle(fontSize: 20.0, height: 1.3)),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: const Text('526',
                            style: TextStyle(fontSize: 40.0),
                            textAlign: TextAlign.center),
                      ),
                      const Text('Attendees',
                          style: TextStyle(fontSize: 24.0),
                          textAlign: TextAlign.center),
                      Container(
                        width: 265,
                        margin: const EdgeInsets.symmetric(vertical: 30.0),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color(0xffA3A3A3)))),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff7D2721)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20.0)),
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(350)),
                        ),
                        onPressed: () {},
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                  padding: EdgeInsets.only(right: 20.0),
                                  child: Icon(Icons.person_add,
                                      color: Colors.white)),
                              Text(
                                'Register for Event',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24.0,
                                ),
                              ),
                            ]),
                      ),
                    ]),
              ),
            ),
          ])),
    );
  }
}

class EventGreekLife extends StatefulWidget {
  const EventGreekLife({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EventGreekLifeState();
  }
}

class _EventGreekLifeState extends State<EventGreekLife> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90.0),
          child: Stack(children: [
            AppBar(
              leading: Align(
                alignment: Alignment.topLeft,
                child: Builder(builder: (BuildContext context) {
                  return BackButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BrowseSocial()),
                      );
                    },
                  );
                }),
              ),
              toolbarHeight: 60,
              centerTitle: true,
              title: const Text(
                'Greek Life Farewell Dinner',
                style: TextStyle(fontSize: 28.0),
              ),
              backgroundColor: const Color(0xff7D2721),
              actions: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    padding: const EdgeInsets.only(right: 30),
                    icon: const Icon(Icons.menu, size: 40.0),
                    tooltip: 'Open menu',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Menu()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ])),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 15.0)),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xffF2CF73)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: const Text('Social', style: TextStyle(fontSize: 20.0)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BrowseSocial()),
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.only(left: 20.0, top: 40.0, bottom: 10.0),
              child: const Text('Event Information',
                  style: TextStyle(fontSize: 40.0), textAlign: TextAlign.left),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: const Text('6-9 PM',
                  style: TextStyle(fontSize: 24.0), textAlign: TextAlign.left),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: const Text('BLACK FRATERNITY HOUSE',
                  style: TextStyle(fontSize: 24.0), textAlign: TextAlign.left),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: const Text('April 08, 2022',
                  style: TextStyle(fontSize: 24.0), textAlign: TextAlign.left),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: const Text(
                  'BLACK FRATERNITY NAME is hosting a farewell dinner for their graduating seniors. Fraternity members are required to come and guests are welcome if they have an official invitation from a brother.',
                  style: TextStyle(fontSize: 20.0, height: 1.3)),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: const Text('39',
                            style: TextStyle(fontSize: 40.0),
                            textAlign: TextAlign.center),
                      ),
                      const Text('Attendees',
                          style: TextStyle(fontSize: 24.0),
                          textAlign: TextAlign.center),
                      Container(
                        width: 265,
                        margin: const EdgeInsets.symmetric(vertical: 30.0),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color(0xffA3A3A3)))),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff7D2721)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20.0)),
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(350)),
                        ),
                        onPressed: () {},
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                  padding: EdgeInsets.only(right: 20.0),
                                  child: Icon(Icons.person_add,
                                      color: Colors.white)),
                              Text(
                                'Register for Event',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24.0,
                                ),
                              ),
                            ]),
                      ),
                    ]),
              ),
            ),
          ])),
    );
  }
}

class StoreExample extends StatefulWidget {
  const StoreExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StoreExampleState();
  }
}

class _StoreExampleState extends State<StoreExample> {
  _launchWebsite() async {
    final website = Uri.parse(
        "https://www.walmart.com/store/2339-west-lafayette-in?cn=Tracking_local_pack_1");
    if (!await launchUrl(website)) {
      throw 'Could not launch URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(220.0),
            child: Stack(children: [
              AppBar(
                leading: Align(
                  alignment: Alignment.topLeft,
                  child: Builder(builder: (BuildContext context) {
                    return BackButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BrowseShopping()),
                        );
                      },
                    );
                  }),
                ),
                toolbarHeight: 60,
                centerTitle: true,
                title: const Text(
                  'Walmart SuperCenter',
                  style: TextStyle(fontSize: 30.0),
                ),
                backgroundColor: const Color(0xff7D2721),
                actions: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      padding: const EdgeInsets.only(right: 30),
                      icon: const Icon(Icons.menu, size: 40.0),
                      tooltip: 'Open menu',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Menu()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  alignment: Alignment.bottomCenter,
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.25),
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(8.0),
                    shape: BoxShape.rectangle,
                    image: const DecorationImage(
                        image: AssetImage('images/walmart.png'),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ])),
        body: ListView(children: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: const [
                        Icon(Icons.near_me, size: 20.0),
                        Text(' 3.5 Mi Away', style: TextStyle(fontSize: 20.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: const [
                        FaIcon(FontAwesomeIcons.clock, size: 20.0),
                        Text(' Open Now',
                            style: TextStyle(
                                fontSize: 20.0, color: Color(0xff495E1C))),
                      ],
                    ),
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 15.0)),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffF2CF73)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        child: const Text('Shopping',
                            style: TextStyle(fontSize: 20.0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BrowseShopping()),
                          );
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 15.0)),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffF2CF73)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child:
                          const Text('Food', style: TextStyle(fontSize: 20.0)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BrowseFood()),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 15.0)),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffF2CF73)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text('Services',
                          style: TextStyle(fontSize: 20.0)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BrowseServices()),
                        );
                      },
                    ),
                  )
                ]),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 40.0, bottom: 10.0),
                  child: const Text('Store Information',
                      style: TextStyle(fontSize: 40.0),
                      textAlign: TextAlign.left),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 26.0),
                  child: Row(
                    children: const [
                      Text('4.1',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20.0)),
                      Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 7.0),
                          child: Icon(Icons.star,
                              color: Color(0xffF2CF73), size: 27.0)),
                      Text('3,079 Google Reviews',
                          style: TextStyle(
                              fontSize: 18.0,
                              decoration: TextDecoration.underline))
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton(
                        onPressed: _launchWebsite,
                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                                const Size.fromWidth(100)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10.0)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffEDEDED))),
                        child: const Text('Website',
                            style: TextStyle(
                                color: Colors.black, fontSize: 20.0)))),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                  child: const Text('Hours',
                      style: TextStyle(fontSize: 30.0),
                      textAlign: TextAlign.left),
                ),
                Row(children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: const Text('Sunday - Saturday',
                        style: TextStyle(fontSize: 20.0, height: 1.3)),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: const Text('6AM - 11PM',
                        style: TextStyle(fontSize: 20.0, height: 1.3)),
                  ),
                ]),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                  child: const Text('Address',
                      style: TextStyle(fontSize: 30.0),
                      textAlign: TextAlign.left),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                  child: const Text(
                      '2801 Northwestern Ave, West Lafayette, IN 47906',
                      style: TextStyle(fontSize: 20.0, height: 1.3)),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                                const Size.fromWidth(150)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10.0)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffEDEDED))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.directions,
                                  size: 30.0, color: Colors.black),
                              Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text('Directions',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20.0)))
                            ]))),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                  child: const Text('Phone',
                      style: TextStyle(fontSize: 30.0),
                      textAlign: TextAlign.left),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                  child: const Text('(765) 463-0201',
                      style: TextStyle(fontSize: 20.0, height: 1.3)),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                                const Size.fromWidth(100)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10.0)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffEDEDED))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.phone,
                                  size: 30.0, color: Colors.black),
                              Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text('Call',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20.0)))
                            ]))),
              ])),
        ]));
  }
}

class MessageGroupPage extends StatelessWidget {
  const MessageGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget messages = Column(children: [
      Align(
        alignment: Alignment.topRight,
        child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.only(right: 20.0, top: 20.0, bottom: 10.0),
            width: 180,
            decoration: BoxDecoration(
                color: const Color(0xffEDEDED),
                borderRadius: BorderRadius.circular(8.0)),
            child: const Text(
                'Hey! I am interested in joining the club. Could you tell me more about it?',
                style: TextStyle(fontSize: 20.0))),
      ),
      Align(
        alignment: Alignment.topLeft,
        child: Container(
            padding: const EdgeInsets.all(20.0),
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            width: 180,
            decoration: BoxDecoration(
                color: const Color(0xffACC664),
                borderRadius: BorderRadius.circular(8.0)),
            child: const Text(
                'We would be happy to have you! What would you like to know?',
                style: TextStyle(fontSize: 20.0))),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Container(
            padding: const EdgeInsets.all(20.0),
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            width: 180,
            decoration: BoxDecoration(
                color: const Color(0xffEDEDED),
                borderRadius: BorderRadius.circular(8.0)),
            child: const Text('How often do you meet?',
                style: TextStyle(fontSize: 20.0))),
      ),
      Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.only(right: 20.0),
          child: const Text('Delivered')),
    ]);

    Widget addComment = Expanded(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 75,
                decoration: BoxDecoration(
                    color: const Color(0xffEDEDED),
                    border: Border.all(color: const Color(0xffA3A3A3))),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_a_photo, size: 30.0)),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: const Color(0xffA3A3A3))),
                    child:
                        Stack(alignment: Alignment.centerLeft, children: const [
                      Text('Text Message',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0, color: Color(0xff6B6B6B))),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.send, size: 30.0),
                      )
                    ]),
                  ))
                ]))));

    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrgExample()),
              );
            },
          );
        }),
        centerTitle: true,
        toolbarHeight: 60,
        title:
            const Text('Black Student Union', style: TextStyle(fontSize: 24.0)),
        backgroundColor: const Color(0xff7D2721),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 30),
            icon: const Icon(Icons.menu, size: 40.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Menu()),
              );
            },
          ),
        ],
      ),
      body: Column(children: [
        messages,
        addComment,
      ]),
    );
  }
}

class ChatForumPage extends StatefulWidget {
  const ChatForumPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChatForumPageState();
  }
}

class _ChatForumPageState extends State<ChatForumPage> {
  Color _thumbsUpColor = Colors.black;
  Color _thumbsDownColor = Colors.black;
  Color _bookmarkColor = Colors.black;
  bool thumbsup = false;
  bool thumbsdown = false;
  bool bookmark = false;
  Icon bookmarkIcon = const Icon(Icons.bookmark_add);

  Color _thumbsUpColor2 = Colors.black;
  Color _thumbsDownColor2 = Colors.black;
  Color _bookmarkColor2 = Colors.black;
  bool thumbsup2 = false;
  bool thumbsdown2 = false;
  bool bookmark2 = false;
  Icon bookmarkIcon2 = const Icon(Icons.bookmark_add);

  Color _thumbsUpColor3 = Colors.black;
  Color _thumbsDownColor3 = Colors.black;
  Color _bookmarkColor3 = Colors.black;
  bool thumbsup3 = false;
  bool thumbsdown3 = false;
  bool bookmark3 = false;
  Icon bookmarkIcon3 = const Icon(Icons.bookmark_add);

  Color _thumbsUpColor4 = Colors.black;
  Color _thumbsDownColor4 = Colors.black;
  Color _bookmarkColor4 = Colors.black;
  bool thumbsup4 = false;
  bool thumbsdown4 = false;
  bool bookmark4 = false;
  Icon bookmarkIcon4 = const Icon(Icons.bookmark_add);

  @override
  Widget build(BuildContext context) {
    Widget comments = ListView(
      shrinkWrap: true,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Thread1()),
            );
          },
          child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10.0),
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              width: 350,
              height: 190,
              decoration: BoxDecoration(
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color(0xffB0B0B0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/placeholder.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            'Patrick Lopez',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: const Text(
                          '20 hours ago',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xff6B6B6B)),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Does anyone feel like Purdue needs a mentorship Program?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            height: 1.3),
                      )),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'I was thinking about this lately and I think that Purdue should consider implementing...',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14.0, height: 1.2),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: const Text(
                      'Read More',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                        height: 1.2,
                        color: Color(0xff982F0C),
                      ),
                    ),
                  ),
                  Stack(children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _thumbsUpColor = (thumbsup == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              _thumbsDownColor = Colors.black;
                              thumbsup = (_thumbsUpColor == Colors.black)
                                  ? false
                                  : true;
                              thumbsdown = false;
                            });
                          },
                          icon: Icon(
                            Icons.thumb_up,
                            color: _thumbsUpColor,
                            size: 20.0,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _thumbsDownColor = (thumbsdown == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              _thumbsUpColor = Colors.black;
                              thumbsdown = (_thumbsDownColor == Colors.black)
                                  ? false
                                  : true;
                              thumbsup = false;
                            });
                          },
                          icon: Icon(
                            Icons.thumb_down,
                            color: _thumbsDownColor,
                            size: 20.0,
                          ),
                        ),
                        const Text(
                          '30 comments',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14.0,
                            decoration: TextDecoration.underline,
                            color: Color(0xff982F0C),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _bookmarkColor = (bookmark == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              bookmark = (_bookmarkColor == Colors.black)
                                  ? false
                                  : true;
                              bookmarkIcon = (bookmark == true)
                                  ? const Icon(Icons.bookmark_added)
                                  : const Icon(Icons.bookmark_add);
                            });
                          },
                          icon: bookmarkIcon,
                          color: _bookmarkColor,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ]),
                ],
              )),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Thread2()),
            );
          },
          child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10.0),
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              width: 350,
              height: 171,
              decoration: BoxDecoration(
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color(0xffB0B0B0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/placeholder.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            'Richard Miller',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: const Text(
                          '20 hours ago',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xff6B6B6B)),
                        ),
                      ),
                    ],
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Looking for advice!',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                height: 1.3),
                          ))),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'I would love to talk to an upperclassman about opportunities in the black...',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14.0, height: 1.2),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: const Text(
                      'Read More',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                        height: 1.2,
                        color: Color(0xff982F0C),
                      ),
                    ),
                  ),
                  Stack(children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _thumbsUpColor2 = (thumbsup2 == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              _thumbsDownColor2 = Colors.black;
                              thumbsup2 = (_thumbsUpColor2 == Colors.black)
                                  ? false
                                  : true;
                              thumbsdown2 = false;
                            });
                          },
                          icon: Icon(
                            Icons.thumb_up,
                            color: _thumbsUpColor2,
                            size: 20.0,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _thumbsDownColor2 = (thumbsdown2 == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              _thumbsUpColor2 = Colors.black;
                              thumbsdown2 = (_thumbsDownColor2 == Colors.black)
                                  ? false
                                  : true;
                              thumbsup2 = false;
                            });
                          },
                          icon: Icon(
                            Icons.thumb_down,
                            color: _thumbsDownColor2,
                            size: 20.0,
                          ),
                        ),
                        const Text(
                          '30 comments',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14.0,
                            decoration: TextDecoration.underline,
                            color: Color(0xff982F0C),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _bookmarkColor2 = (bookmark2 == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              bookmark2 = (_bookmarkColor2 == Colors.black)
                                  ? false
                                  : true;
                              bookmarkIcon2 = (bookmark2 == true)
                                  ? const Icon(Icons.bookmark_added)
                                  : const Icon(Icons.bookmark_add);
                            });
                          },
                          icon: bookmarkIcon2,
                          color: _bookmarkColor2,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ]),
                ],
              )),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10.0),
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              width: 350,
              height: 171,
              decoration: BoxDecoration(
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color(0xffB0B0B0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/placeholder.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            'Andrea Smith',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: const Text(
                          '6 hours ago',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xff6B6B6B)),
                        ),
                      ),
                    ],
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Looking for a group to play basketball with',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                height: 1.3),
                          ))),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'None of my friends like basketball so I would like to find people who do lol',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14.0, height: 1.2),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: const Text(
                      'Read More',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                        height: 1.2,
                        color: Color(0xff982F0C),
                      ),
                    ),
                  ),
                  Stack(children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _thumbsUpColor3 = (thumbsup3 == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              _thumbsDownColor3 = Colors.black;
                              thumbsup3 = (_thumbsUpColor3 == Colors.black)
                                  ? false
                                  : true;
                              thumbsdown3 = false;
                            });
                          },
                          icon: Icon(
                            Icons.thumb_up,
                            color: _thumbsUpColor3,
                            size: 20.0,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _thumbsDownColor3 = (thumbsdown3 == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              _thumbsUpColor3 = Colors.black;
                              thumbsdown3 = (_thumbsDownColor3 == Colors.black)
                                  ? false
                                  : true;
                              thumbsup3 = false;
                            });
                          },
                          icon: Icon(
                            Icons.thumb_down,
                            color: _thumbsDownColor3,
                            size: 20.0,
                          ),
                        ),
                        const Text(
                          '5 comments',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14.0,
                            decoration: TextDecoration.underline,
                            color: Color(0xff982F0C),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _bookmarkColor3 = (bookmark3 == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              bookmark3 = (_bookmarkColor3 == Colors.black)
                                  ? false
                                  : true;
                              bookmarkIcon3 = (bookmark3 == true)
                                  ? const Icon(Icons.bookmark_added)
                                  : const Icon(Icons.bookmark_add);
                            });
                          },
                          icon: bookmarkIcon3,
                          color: _bookmarkColor3,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ]),
                ],
              )),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10.0),
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              width: 350,
              height: 154,
              decoration: BoxDecoration(
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color(0xffB0B0B0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/placeholder.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const Text(
                            'Kiara Sims',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: const Text(
                          '6 hours ago',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xff6B6B6B)),
                        ),
                      ),
                    ],
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'PSA: Tastes of Chicago is SO good!',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                height: 1.3),
                          ))),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'I highly recommend it! Plus its great to support local businesses',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14.0, height: 1.2),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: const Text(
                      'Read More',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                        height: 1.2,
                        color: Color(0xff982F0C),
                      ),
                    ),
                  ),
                  Stack(children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _thumbsUpColor4 = (thumbsup4 == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              _thumbsDownColor4 = Colors.black;
                              thumbsup4 = (_thumbsUpColor4 == Colors.black)
                                  ? false
                                  : true;
                              thumbsdown4 = false;
                            });
                          },
                          icon: Icon(
                            Icons.thumb_up,
                            color: _thumbsUpColor4,
                            size: 20.0,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _thumbsDownColor4 = (thumbsdown4 == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              _thumbsUpColor4 = Colors.black;
                              thumbsdown4 = (_thumbsDownColor4 == Colors.black)
                                  ? false
                                  : true;
                              thumbsup4 = false;
                            });
                          },
                          icon: Icon(
                            Icons.thumb_down,
                            color: _thumbsDownColor4,
                            size: 20.0,
                          ),
                        ),
                        const Text(
                          '2 comments',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14.0,
                            decoration: TextDecoration.underline,
                            color: Color(0xff982F0C),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _bookmarkColor4 = (bookmark4 == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              bookmark4 = (_bookmarkColor4 == Colors.black)
                                  ? false
                                  : true;
                              bookmarkIcon4 = (bookmark4 == true)
                                  ? const Icon(Icons.bookmark_added)
                                  : const Icon(Icons.bookmark_add);
                            });
                          },
                          icon: bookmarkIcon4,
                          color: _bookmarkColor4,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ]),
                ],
              )),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.add, size: 40.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddThread()),
              );
            },
          );
        }),
        centerTitle: true,
        toolbarHeight: 60,
        title: const Text('Chat Forum', style: TextStyle(fontSize: 24.0)),
        backgroundColor: const Color(0xff7D2721),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 30),
            icon: const Icon(Icons.menu, size: 40.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Menu()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: OutlinedButton.icon(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      const BorderSide(color: Color(0xffA3A3A3))),
                  alignment: Alignment.centerLeft,
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xffEDEDED)),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                  fixedSize:
                      MaterialStateProperty.all(const Size.fromWidth(220)),
                ),
                onPressed: () {},
                label: const Text(
                  'Search...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff6B6B6B),
                  ),
                ),
                icon: const Icon(
                  Icons.search,
                  size: 30.0,
                  color: Color(0xff6B6B6B),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          const BorderSide(color: Color(0xffA3A3A3))),
                      alignment: Alignment.center,
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                      fixedSize:
                          MaterialStateProperty.all(const Size.fromWidth(70)),
                    ),
                    onPressed: () {},
                    child: Row(mainAxisSize: MainAxisSize.min, children: const [
                      Text(
                        'Filter',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff6B6B6B),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.filter_alt,
                        size: 15.0,
                      ),
                    ]),
                  )),
              OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      const BorderSide(color: Color(0xffA3A3A3))),
                  alignment: Alignment.center,
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  fixedSize:
                      MaterialStateProperty.all(const Size.fromWidth(100)),
                ),
                onPressed: () {},
                child: Row(mainAxisSize: MainAxisSize.min, children: const [
                  Text(
                    'Sort by...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff6B6B6B),
                    ),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 30.0,
                  ),
                ]),
              ),
            ],
          ),
          Expanded(
            child: comments,
          )
        ],
      ),
    );
  }
}

class AddThread extends StatefulWidget {
  const AddThread({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddThreadState();
  }
}

class _AddThreadState extends State<AddThread> {
  Color _AcademicsColor = const Color(0xffF2CF73);
  Color _FitnessColor = const Color(0xffF2CF73);
  Color _FoodColor = const Color(0xffF2CF73);
  Color _HobbiesColor = const Color(0xffF2CF73);
  Color _PersonalCareColor = const Color(0xffF2CF73);
  Color _PurdueProgramsColor = const Color(0xffF2CF73);
  Color _ReligiousColor = const Color(0xffF2CF73);
  Color _ServicesColor = const Color(0xffF2CF73);
  Color _ShoppingColor = const Color(0xffF2CF73);
  Color _SocialColor = const Color(0xffF2CF73);

  bool academics = false;
  bool fitness = false;
  bool food = false;
  bool hobbies = false;
  bool personalCare = false;
  bool purduePrograms = false;
  bool religious = false;
  bool services = false;
  bool shopping = false;
  bool social = false;

  int counter = 0;
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.close, size: 40.0),
              onPressed: () => showDialog<String>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                      'Are you sure you want to delete this thread?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28.0, height: 1.4)),
                  content: const Text('This cannot be undone.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0)),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff535353)),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 10.0))),
                            onPressed: () => Navigator.pop(context, 'No'),
                            child: const Text('No',
                                style: TextStyle(fontSize: 30.0)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff7D2721)),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 10.0))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChatForumPage()),
                              );
                            },
                            child: const Text('Yes',
                                style: TextStyle(fontSize: 30.0)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
          centerTitle: true,
          toolbarHeight: 60,
          title: const Text('Add Thread', style: TextStyle(fontSize: 24.0)),
          backgroundColor: const Color(0xff7D2721),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.menu, size: 40.0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Thread Title',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontFamily: 'UnitedSans'),
                      children: <TextSpan>[
                        TextSpan(
                            text: '*',
                            style: TextStyle(color: Color(0xff982F0C))),
                      ],
                    ),
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          const BorderSide(color: Color(0xffA3A3A3))),
                      alignment: Alignment.centerLeft,
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xffEDEDED)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0)),
                      fixedSize: MaterialStateProperty.all(
                          Size.fromWidth(MediaQuery.of(context).size.width)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Type here...',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xff6B6B6B),
                      ),
                    ),
                  )),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Thread Body',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontFamily: 'UnitedSans'),
                      children: <TextSpan>[
                        TextSpan(
                            text: '*',
                            style: TextStyle(color: Color(0xff982F0C))),
                      ],
                    ),
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          const BorderSide(color: Color(0xffA3A3A3))),
                      alignment: Alignment.topLeft,
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xffEDEDED)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0)),
                      fixedSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width, 130.0)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Type here...',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xff6B6B6B),
                      ),
                    ),
                  )),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_a_photo, size: 30.0)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.video_call, size: 30.0)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.upload_file, size: 30.0)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_link, size: 30.0)),
                  ])),
              Row(children: [
                Container(
                    margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                    child: const Text('Categories',
                        style: TextStyle(fontSize: 20.0))),
                Text(
                  (counter != 0) ? '($counter selected)' : '(none selected)',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0)),
                        backgroundColor:
                            MaterialStateProperty.all(_AcademicsColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text('Academics',
                          style: TextStyle(fontSize: 18.0)),
                      onPressed: () {
                        setState(() {
                          _AcademicsColor = (academics == false)
                              ? const Color(0xffACC664)
                              : const Color(0xffF2CF73);
                          academics =
                              (_AcademicsColor == const Color(0xffF2CF73))
                                  ? false
                                  : true;
                          selected = (academics == true) ? true : false;
                          counter = (selected == true)
                              ? (counter + 1)
                              : (counter - 1);
                        });
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0)),
                        backgroundColor:
                            MaterialStateProperty.all(_FitnessColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text('Fitness',
                          style: TextStyle(fontSize: 18.0)),
                      onPressed: () {
                        setState(() {
                          _FitnessColor = (fitness == false)
                              ? const Color(0xffACC664)
                              : const Color(0xffF2CF73);
                          fitness = (_FitnessColor == const Color(0xffF2CF73))
                              ? false
                              : true;
                          selected = (fitness == true) ? true : false;
                          counter = counter = (selected == true)
                              ? (counter + 1)
                              : (counter - 1);
                        });
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0)),
                        backgroundColor: MaterialStateProperty.all(_FoodColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child:
                          const Text('Food', style: TextStyle(fontSize: 18.0)),
                      onPressed: () {
                        setState(() {
                          _FoodColor = (food == false)
                              ? const Color(0xffACC664)
                              : const Color(0xffF2CF73);
                          food = (_FoodColor == const Color(0xffF2CF73))
                              ? false
                              : true;
                          selected = (food == true) ? true : false;
                          counter = (selected == true)
                              ? (counter + 1)
                              : (counter - 1);
                        });
                      },
                    )),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0)),
                        backgroundColor:
                            MaterialStateProperty.all(_HobbiesColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text('Hobbies',
                          style: TextStyle(fontSize: 18.0)),
                      onPressed: () {
                        setState(() {
                          _HobbiesColor = (hobbies == false)
                              ? const Color(0xffACC664)
                              : const Color(0xffF2CF73);
                          hobbies = (_HobbiesColor == const Color(0xffF2CF73))
                              ? false
                              : true;
                          selected = (hobbies == true) ? true : false;
                          counter = (selected == true)
                              ? (counter + 1)
                              : (counter - 1);
                        });
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0)),
                        backgroundColor:
                            MaterialStateProperty.all(_PersonalCareColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text('Personal Care',
                          style: TextStyle(fontSize: 18.0)),
                      onPressed: () {
                        setState(() {
                          _PersonalCareColor = (personalCare == false)
                              ? const Color(0xffACC664)
                              : const Color(0xffF2CF73);
                          personalCare =
                              (_PersonalCareColor == const Color(0xffF2CF73))
                                  ? false
                                  : true;
                          selected = (personalCare == true) ? true : false;
                          counter = (selected == true)
                              ? (counter + 1)
                              : (counter - 1);
                        });
                      },
                    )),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0)),
                        backgroundColor:
                            MaterialStateProperty.all(_PurdueProgramsColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text('Purdue Programs',
                          style: TextStyle(fontSize: 18.0)),
                      onPressed: () {
                        setState(() {
                          _PurdueProgramsColor = (purduePrograms == false)
                              ? const Color(0xffACC664)
                              : const Color(0xffF2CF73);
                          purduePrograms =
                              (_PurdueProgramsColor == const Color(0xffF2CF73))
                                  ? false
                                  : true;
                          selected = (purduePrograms == true) ? true : false;
                          counter = (selected == true)
                              ? (counter + 1)
                              : (counter - 1);
                        });
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0)),
                        backgroundColor:
                            MaterialStateProperty.all(_ReligiousColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text('Religious',
                          style: TextStyle(fontSize: 18.0)),
                      onPressed: () {
                        setState(() {
                          _ReligiousColor = (religious == false)
                              ? const Color(0xffACC664)
                              : const Color(0xffF2CF73);
                          religious =
                              (_ReligiousColor == const Color(0xffF2CF73))
                                  ? false
                                  : true;
                          selected = (religious == true) ? true : false;
                          counter = (selected == true)
                              ? (counter + 1)
                              : (counter - 1);
                        });
                      },
                    )),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0)),
                        backgroundColor:
                            MaterialStateProperty.all(_ServicesColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text('Services',
                          style: TextStyle(fontSize: 18.0)),
                      onPressed: () {
                        setState(() {
                          _ServicesColor = (services == false)
                              ? const Color(0xffACC664)
                              : const Color(0xffF2CF73);
                          services = (_ServicesColor == const Color(0xffF2CF73))
                              ? false
                              : true;
                          selected = (services == true) ? true : false;
                          counter = (selected == true)
                              ? (counter + 1)
                              : (counter - 1);
                        });
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0)),
                        backgroundColor:
                            MaterialStateProperty.all(_ShoppingColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text('Shopping',
                          style: TextStyle(fontSize: 18.0)),
                      onPressed: () {
                        setState(() {
                          _ShoppingColor = (shopping == false)
                              ? const Color(0xffACC664)
                              : const Color(0xffF2CF73);
                          shopping = (_ShoppingColor == const Color(0xffF2CF73))
                              ? false
                              : true;
                          selected = (shopping == true) ? true : false;
                          counter = (selected == true)
                              ? (counter + 1)
                              : (counter - 1);
                        });
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0)),
                        backgroundColor:
                            MaterialStateProperty.all(_SocialColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text('Social',
                          style: TextStyle(fontSize: 18.0)),
                      onPressed: () {
                        setState(() {
                          _SocialColor = (social == false)
                              ? const Color(0xffACC664)
                              : const Color(0xffF2CF73);
                          social = (_SocialColor == const Color(0xffF2CF73))
                              ? false
                              : true;
                          selected = (social == true) ? true : false;
                          counter = (selected == true)
                              ? (counter + 1)
                              : (counter - 1);
                        });
                      },
                    )),
              ]),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff7D2721)),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20.0)),
                      fixedSize:
                          MaterialStateProperty.all(const Size.fromWidth(350)),
                    ),
                    onPressed: () => showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          Future.delayed(
                            const Duration(seconds: 2),
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChatForumPage()),
                              );
                            },
                          );
                          return const AlertDialog(
                            title: Icon(Icons.check_circle,
                                size: 75.0, color: Color(0xff495E1C)),
                            content: Text('Published!',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 32.0)),
                          );
                        }),
                    child: const Text(
                      'Publish Post',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class Thread1 extends StatefulWidget {
  const Thread1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Thread1State();
  }
}

class _Thread1State extends State<Thread1> {
  bool bookmark = false;
  Color _bookmarkColor = Colors.black;
  Icon bookmarkIcon = const Icon(Icons.bookmark_add, size: 40.0);

  Color _thumbsUpColor = Colors.black;
  Color _thumbsDownColor = Colors.black;
  int thumbsUpCounter = 16;
  int thumbsDownCounter = 3;
  bool thumbsup = false;
  bool thumbsdown = false;

  Color _thumbsUpColor2 = Colors.black;
  Color _thumbsDownColor2 = Colors.black;
  int thumbsUpCounter2 = 9;
  int thumbsDownCounter2 = 0;
  bool thumbsup2 = false;
  bool thumbsdown2 = false;

  Color _thumbsUpColor3 = Colors.black;
  Color _thumbsDownColor3 = Colors.black;
  int thumbsUpCounter3 = 5;
  int thumbsDownCounter3 = 2;
  bool thumbsup3 = false;
  bool thumbsdown3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatForumPage()),
              );
            },
          );
        }),
        centerTitle: true,
        toolbarHeight: 60,
        title: const Text('Chat Thread', style: TextStyle(fontSize: 24.0)),
        backgroundColor: const Color(0xff7D2721),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 30),
            icon: const Icon(Icons.menu, size: 40.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Menu()),
              );
            },
          ),
        ],
      ),
      body: ListView(shrinkWrap: true, children: [
        Stack(children: [
          Container(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('images/placeholder.png'),
                        fit: BoxFit.fill),
                  ),
                ),
                Column(children: [
                  const Text(
                    'Patrick Lopez',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 24.0, color: Colors.black),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 5.0),
                    child: const Text(
                      '20 hours ago',
                      style:
                          TextStyle(fontSize: 16.0, color: Color(0xff6B6B6B)),
                    ),
                  )
                ]),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _bookmarkColor = (bookmark == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              bookmark = (_bookmarkColor == Colors.black)
                                  ? false
                                  : true;
                              bookmarkIcon = (bookmark == true)
                                  ? const Icon(Icons.bookmark_added, size: 40.0)
                                  : const Icon(Icons.bookmark_add, size: 40.0);
                            });
                          },
                          icon: bookmarkIcon,
                          color: _bookmarkColor,
                        ),
                      )),
                )
              ],
            ),
          )
        ]),
        Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                          'Does anyone feel like Purdue needs a mentorship program?',
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              height: 1.3))),
                  Text(
                      'I was thinking about this lately and I think that Purdue should consider implenting a mentorship program. When I was a freshman, I was overwhelmed by the various different things offered on campus and it took me a long time of socializing with random students on campus to actually feel like I knew enough about campus. Having an upperclassman to talk to during freshman year could help students acclimate to campus.',
                      style: TextStyle(fontSize: 18.0, height: 1.2))
                ])),
        Row(children: [
          Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 5.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0)),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xffF2CF73)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: const Text('Hobbies', style: TextStyle(fontSize: 18.0)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BrowseHobbies()),
                  );
                },
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0)),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xffF2CF73)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: const Text('Social', style: TextStyle(fontSize: 18.0)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BrowseSocial()),
                  );
                },
              )),
        ]),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(thumbsUpCounter.toString(),
                  style: const TextStyle(fontSize: 20.0)),
              IconButton(
                onPressed: () {
                  setState(() {
                    _thumbsUpColor = (thumbsup == true)
                        ? Colors.black
                        : const Color(0xff982F0C);
                    _thumbsDownColor = Colors.black;
                    thumbsDownCounter = (thumbsdown == true)
                        ? (thumbsDownCounter - 1)
                        : (thumbsDownCounter);
                    thumbsup = (_thumbsUpColor == Colors.black) ? false : true;
                    thumbsdown = false;
                    thumbsUpCounter = (thumbsup == true)
                        ? thumbsUpCounter += 1
                        : thumbsUpCounter -= 1;
                  });
                },
                icon: Icon(
                  Icons.thumb_up,
                  color: _thumbsUpColor,
                  size: 30.0,
                ),
              ),
              Text(thumbsDownCounter.toString(),
                  style: const TextStyle(fontSize: 20.0)),
              IconButton(
                onPressed: () {
                  setState(() {
                    _thumbsDownColor = (thumbsdown == true)
                        ? Colors.black
                        : const Color(0xff982F0C);
                    _thumbsUpColor = Colors.black;
                    thumbsUpCounter = (thumbsup == true)
                        ? (thumbsUpCounter - 1)
                        : (thumbsUpCounter);
                    thumbsdown =
                        (_thumbsDownColor == Colors.black) ? false : true;
                    thumbsup = false;
                    thumbsDownCounter = (thumbsdown == true)
                        ? thumbsDownCounter += 1
                        : thumbsDownCounter -= 1;
                  });
                },
                icon: Icon(
                  Icons.thumb_down,
                  color: _thumbsDownColor,
                  size: 30.0,
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Color(0xffA3A3A3), width: 3.0))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Text(
                              'Comments',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                          Icon(Icons.chat),
                          Text(' 30', style: TextStyle(fontSize: 24))
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          width: 350,
                          height: 140,
                          decoration: BoxDecoration(
                              color: const Color(0xffEDEDED),
                              borderRadius: BorderRadius.circular(8.0),
                              border:
                                  Border.all(color: const Color(0xffB0B0B0))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10.0),
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'images/placeholder.png'),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      const Text(
                                        'FirstName LastName',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: const Text(
                                      '3 hours ago',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Color(0xff6B6B6B)),
                                    ),
                                  ),
                                ],
                              ),
                              const Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text(
                                    'If I had a program like that as a freshman my experiences would have been much different!',
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontSize: 14.0, height: 1.2),
                                  ),
                                ),
                              ),
                              Stack(alignment: Alignment.center, children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.reply,
                                      size: 20,
                                    ),
                                    Text('Reply')
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(thumbsUpCounter2.toString()),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _thumbsUpColor2 = (thumbsup2 == true)
                                              ? Colors.black
                                              : const Color(0xff982F0C);
                                          _thumbsDownColor2 = Colors.black;
                                          thumbsDownCounter2 =
                                              (thumbsdown2 == true)
                                                  ? (thumbsDownCounter2 - 1)
                                                  : (thumbsDownCounter2);
                                          thumbsup2 =
                                              (_thumbsUpColor2 == Colors.black)
                                                  ? false
                                                  : true;
                                          thumbsdown2 = false;
                                          thumbsUpCounter2 = (thumbsup2 == true)
                                              ? thumbsUpCounter2 += 1
                                              : thumbsUpCounter2 -= 1;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.thumb_up,
                                        color: _thumbsUpColor2,
                                        size: 20.0,
                                      ),
                                    ),
                                    Text(thumbsDownCounter2.toString()),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _thumbsDownColor2 =
                                              (thumbsdown2 == true)
                                                  ? Colors.black
                                                  : const Color(0xff982F0C);
                                          _thumbsUpColor2 = Colors.black;
                                          thumbsUpCounter2 = (thumbsup2 == true)
                                              ? (thumbsUpCounter2 - 1)
                                              : (thumbsUpCounter2);
                                          thumbsdown2 = (_thumbsDownColor2 ==
                                                  Colors.black)
                                              ? false
                                              : true;
                                          thumbsup2 = false;
                                          thumbsDownCounter2 =
                                              (thumbsdown2 == true)
                                                  ? thumbsDownCounter2 += 1
                                                  : thumbsDownCounter2 -= 1;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.thumb_down,
                                        color: _thumbsDownColor2,
                                        size: 20.0,
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          width: 350,
                          height: 130,
                          decoration: BoxDecoration(
                              color: const Color(0xffEDEDED),
                              borderRadius: BorderRadius.circular(8.0),
                              border:
                                  Border.all(color: const Color(0xffB0B0B0))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10.0),
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'images/placeholder.png'),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      const Text(
                                        'FirstName LastName',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: const Text(
                                      '12 hours ago',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Color(0xff6B6B6B)),
                                    ),
                                  ),
                                ],
                              ),
                              const Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    'I think it is a great idea for freshman who are new to campus. Great idea!',
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontSize: 14.0, height: 1.2),
                                  ),
                                ),
                              ),
                              Stack(alignment: Alignment.center, children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.reply,
                                      size: 20,
                                    ),
                                    Text('Reply')
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(thumbsUpCounter3.toString()),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _thumbsUpColor3 = (thumbsup3 == true)
                                              ? Colors.black
                                              : const Color(0xff982F0C);
                                          _thumbsDownColor3 = Colors.black;
                                          thumbsDownCounter3 =
                                              (thumbsdown3 == true)
                                                  ? (thumbsDownCounter3 - 1)
                                                  : (thumbsDownCounter3);
                                          thumbsup3 =
                                              (_thumbsUpColor3 == Colors.black)
                                                  ? false
                                                  : true;
                                          thumbsdown3 = false;
                                          thumbsUpCounter3 = (thumbsup3 == true)
                                              ? thumbsUpCounter3 += 1
                                              : thumbsUpCounter3 -= 1;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.thumb_up,
                                        color: _thumbsUpColor3,
                                        size: 20.0,
                                      ),
                                    ),
                                    Text(thumbsDownCounter3.toString()),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _thumbsDownColor3 =
                                              (thumbsdown3 == true)
                                                  ? Colors.black
                                                  : const Color(0xff982F0C);
                                          _thumbsUpColor3 = Colors.black;
                                          thumbsUpCounter3 = (thumbsup3 == true)
                                              ? (thumbsUpCounter3 - 1)
                                              : (thumbsUpCounter3);
                                          thumbsdown3 = (_thumbsDownColor3 ==
                                                  Colors.black)
                                              ? false
                                              : true;
                                          thumbsup3 = false;
                                          thumbsDownCounter3 =
                                              (thumbsdown3 == true)
                                                  ? thumbsDownCounter3 += 1
                                                  : thumbsDownCounter3 -= 1;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.thumb_down,
                                        color: _thumbsDownColor3,
                                        size: 20.0,
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                            ],
                          )),
                    ),
                  ],
                ))),
        Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 75,
                    decoration: BoxDecoration(
                        color: const Color(0xffEDEDED),
                        border: Border.all(color: const Color(0xffA3A3A3))),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: const Color(0xffA3A3A3))),
                        child: Stack(
                            alignment: Alignment.centerLeft,
                            children: const [
                              Text('Add Comment...',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Color(0xff6B6B6B))),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.send, size: 30.0),
                              )
                            ]))))),
      ]),
    );
  }
}

class Thread2 extends StatefulWidget {
  const Thread2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Thread2State();
  }
}

class _Thread2State extends State<Thread2> {
  bool bookmark = false;
  Color _bookmarkColor = Colors.black;
  Icon bookmarkIcon = const Icon(Icons.bookmark_add, size: 40.0);

  Color _thumbsUpColor = Colors.black;
  Color _thumbsDownColor = Colors.black;
  int thumbsUpCounter = 16;
  int thumbsDownCounter = 3;
  bool thumbsup = false;
  bool thumbsdown = false;

  Color _thumbsUpColor2 = Colors.black;
  Color _thumbsDownColor2 = Colors.black;
  int thumbsUpCounter2 = 9;
  int thumbsDownCounter2 = 0;
  bool thumbsup2 = false;
  bool thumbsdown2 = false;

  Color _thumbsUpColor3 = Colors.black;
  Color _thumbsDownColor3 = Colors.black;
  int thumbsUpCounter3 = 5;
  int thumbsDownCounter3 = 2;
  bool thumbsup3 = false;
  bool thumbsdown3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatForumPage()),
              );
            },
          );
        }),
        centerTitle: true,
        toolbarHeight: 60,
        title: const Text('Chat Thread', style: TextStyle(fontSize: 24.0)),
        backgroundColor: const Color(0xff7D2721),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 30),
            icon: const Icon(Icons.menu, size: 40.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Menu()),
              );
            },
          ),
        ],
      ),
      body: ListView(shrinkWrap: true, children: [
        Stack(children: [
          Container(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('images/placeholder.png'),
                        fit: BoxFit.fill),
                  ),
                ),
                Column(children: [
                  const Text(
                    'Richard Miller',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 24.0, color: Colors.black),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 5.0),
                    child: const Text(
                      '20 hours ago',
                      style:
                          TextStyle(fontSize: 16.0, color: Color(0xff6B6B6B)),
                    ),
                  )
                ]),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _bookmarkColor = (bookmark == true)
                                  ? Colors.black
                                  : const Color(0xff982F0C);
                              bookmark = (_bookmarkColor == Colors.black)
                                  ? false
                                  : true;
                              bookmarkIcon = (bookmark == true)
                                  ? const Icon(Icons.bookmark_added, size: 40.0)
                                  : const Icon(Icons.bookmark_add, size: 40.0);
                            });
                          },
                          icon: bookmarkIcon,
                          color: _bookmarkColor,
                        ),
                      )),
                )
              ],
            ),
          )
        ]),
        Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text('Looking for advice!',
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              height: 1.3))),
                  Text(
                      'I would love to talk to an upperclassman about opportunities in the black community. I am a freshman who is looking to connect with other black students on campus but it has been a struggle finding people in my classes.',
                      style: TextStyle(fontSize: 18.0, height: 1.2))
                ])),
        Row(children: [
          Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 5.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0)),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xffF2CF73)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: const Text('Hobbies', style: TextStyle(fontSize: 18.0)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BrowseHobbies()),
                  );
                },
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0)),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xffF2CF73)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: const Text('Social', style: TextStyle(fontSize: 18.0)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BrowseSocial()),
                  );
                },
              )),
        ]),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(thumbsUpCounter.toString(),
                  style: const TextStyle(fontSize: 20.0)),
              IconButton(
                onPressed: () {
                  setState(() {
                    _thumbsUpColor = (thumbsup == true)
                        ? Colors.black
                        : const Color(0xff982F0C);
                    _thumbsDownColor = Colors.black;
                    thumbsDownCounter = (thumbsdown == true)
                        ? (thumbsDownCounter - 1)
                        : (thumbsDownCounter);
                    thumbsup = (_thumbsUpColor == Colors.black) ? false : true;
                    thumbsdown = false;
                    thumbsUpCounter = (thumbsup == true)
                        ? thumbsUpCounter += 1
                        : thumbsUpCounter -= 1;
                  });
                },
                icon: Icon(
                  Icons.thumb_up,
                  color: _thumbsUpColor,
                  size: 30.0,
                ),
              ),
              Text(thumbsDownCounter.toString(),
                  style: const TextStyle(fontSize: 20.0)),
              IconButton(
                onPressed: () {
                  setState(() {
                    _thumbsDownColor = (thumbsdown == true)
                        ? Colors.black
                        : const Color(0xff982F0C);
                    _thumbsUpColor = Colors.black;
                    thumbsUpCounter = (thumbsup == true)
                        ? (thumbsUpCounter - 1)
                        : (thumbsUpCounter);
                    thumbsdown =
                        (_thumbsDownColor == Colors.black) ? false : true;
                    thumbsup = false;
                    thumbsDownCounter = (thumbsdown == true)
                        ? thumbsDownCounter += 1
                        : thumbsDownCounter -= 1;
                  });
                },
                icon: Icon(
                  Icons.thumb_down,
                  color: _thumbsDownColor,
                  size: 30.0,
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Color(0xffA3A3A3), width: 3.0))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Text(
                              'Comments',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                          Icon(Icons.chat),
                          Text(' 30', style: TextStyle(fontSize: 24))
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          width: 350,
                          height: 140,
                          decoration: BoxDecoration(
                              color: const Color(0xffEDEDED),
                              borderRadius: BorderRadius.circular(8.0),
                              border:
                                  Border.all(color: const Color(0xffB0B0B0))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10.0),
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'images/placeholder.png'),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      const Text(
                                        'FirstName LastName',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: const Text(
                                      '3 hours ago',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Color(0xff6B6B6B)),
                                    ),
                                  ),
                                ],
                              ),
                              const Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text(
                                    'If I had a program like that as a freshman my experiences would have been much different!',
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontSize: 14.0, height: 1.2),
                                  ),
                                ),
                              ),
                              Stack(alignment: Alignment.center, children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.reply,
                                      size: 20,
                                    ),
                                    Text('Reply')
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(thumbsUpCounter2.toString()),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _thumbsUpColor2 = (thumbsup2 == true)
                                              ? Colors.black
                                              : const Color(0xff982F0C);
                                          _thumbsDownColor2 = Colors.black;
                                          thumbsDownCounter2 =
                                              (thumbsdown2 == true)
                                                  ? (thumbsDownCounter2 - 1)
                                                  : (thumbsDownCounter2);
                                          thumbsup2 =
                                              (_thumbsUpColor2 == Colors.black)
                                                  ? false
                                                  : true;
                                          thumbsdown2 = false;
                                          thumbsUpCounter2 = (thumbsup2 == true)
                                              ? thumbsUpCounter2 += 1
                                              : thumbsUpCounter2 -= 1;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.thumb_up,
                                        color: _thumbsUpColor2,
                                        size: 20.0,
                                      ),
                                    ),
                                    Text(thumbsDownCounter2.toString()),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _thumbsDownColor2 =
                                              (thumbsdown2 == true)
                                                  ? Colors.black
                                                  : const Color(0xff982F0C);
                                          _thumbsUpColor2 = Colors.black;
                                          thumbsUpCounter2 = (thumbsup2 == true)
                                              ? (thumbsUpCounter2 - 1)
                                              : (thumbsUpCounter2);
                                          thumbsdown2 = (_thumbsDownColor2 ==
                                                  Colors.black)
                                              ? false
                                              : true;
                                          thumbsup2 = false;
                                          thumbsDownCounter2 =
                                              (thumbsdown2 == true)
                                                  ? thumbsDownCounter2 += 1
                                                  : thumbsDownCounter2 -= 1;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.thumb_down,
                                        color: _thumbsDownColor2,
                                        size: 20.0,
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          width: 350,
                          height: 130,
                          decoration: BoxDecoration(
                              color: const Color(0xffEDEDED),
                              borderRadius: BorderRadius.circular(8.0),
                              border:
                                  Border.all(color: const Color(0xffB0B0B0))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10.0),
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'images/placeholder.png'),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      const Text(
                                        'FirstName LastName',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: const Text(
                                      '12 hours ago',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Color(0xff6B6B6B)),
                                    ),
                                  ),
                                ],
                              ),
                              const Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    'I think it is a great idea for freshman who are new to campus. Great idea!',
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontSize: 14.0, height: 1.2),
                                  ),
                                ),
                              ),
                              Stack(alignment: Alignment.center, children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.reply,
                                      size: 20,
                                    ),
                                    Text('Reply')
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(thumbsUpCounter3.toString()),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _thumbsUpColor3 = (thumbsup3 == true)
                                              ? Colors.black
                                              : const Color(0xff982F0C);
                                          _thumbsDownColor3 = Colors.black;
                                          thumbsDownCounter3 =
                                              (thumbsdown3 == true)
                                                  ? (thumbsDownCounter3 - 1)
                                                  : (thumbsDownCounter3);
                                          thumbsup3 =
                                              (_thumbsUpColor3 == Colors.black)
                                                  ? false
                                                  : true;
                                          thumbsdown3 = false;
                                          thumbsUpCounter3 = (thumbsup3 == true)
                                              ? thumbsUpCounter3 += 1
                                              : thumbsUpCounter3 -= 1;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.thumb_up,
                                        color: _thumbsUpColor3,
                                        size: 20.0,
                                      ),
                                    ),
                                    Text(thumbsDownCounter3.toString()),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _thumbsDownColor3 =
                                              (thumbsdown3 == true)
                                                  ? Colors.black
                                                  : const Color(0xff982F0C);
                                          _thumbsUpColor3 = Colors.black;
                                          thumbsUpCounter3 = (thumbsup3 == true)
                                              ? (thumbsUpCounter3 - 1)
                                              : (thumbsUpCounter3);
                                          thumbsdown3 = (_thumbsDownColor3 ==
                                                  Colors.black)
                                              ? false
                                              : true;
                                          thumbsup3 = false;
                                          thumbsDownCounter3 =
                                              (thumbsdown3 == true)
                                                  ? thumbsDownCounter3 += 1
                                                  : thumbsDownCounter3 -= 1;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.thumb_down,
                                        color: _thumbsDownColor3,
                                        size: 20.0,
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                            ],
                          )),
                    ),
                  ],
                ))),
        Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 75,
                    decoration: BoxDecoration(
                        color: const Color(0xffEDEDED),
                        border: Border.all(color: const Color(0xffA3A3A3))),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: const Color(0xffA3A3A3))),
                        child: Stack(
                            alignment: Alignment.centerLeft,
                            children: const [
                              Text('Add Comment...',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Color(0xff6B6B6B))),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.send, size: 30.0),
                              )
                            ]))))),
      ]),
    );
  }
}
