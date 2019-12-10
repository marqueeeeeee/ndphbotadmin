import 'package:flutter/material.dart';

final netflixRed = Color.fromARGB(255, 229, 9, 20);

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: _HomePageView(),
    );
  }
}

class _HomePageView extends StatefulWidget {
  @override
  __HomePageViewState createState() => __HomePageViewState();
}

class __HomePageViewState extends State<_HomePageView>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    animation = Tween<double>(begin: 0, end: -500).animate(animController)
      ..addListener(() {
        setState(() {});
      })..addStatusListener((enumType) {
        switch(enumType) {
          
          case AnimationStatus.dismissed:
            // TODO: Handle this case.
            animController.forward();
            break;
          case AnimationStatus.forward:
            // TODO: Handle this case.
            break;
          case AnimationStatus.reverse:
            // TODO: Handle this case.
            break;
          case AnimationStatus.completed:
            // TODO: Handle this case.
            animController.reverse();
            break;
        }
      });
      
      animController.forward();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: netflixRed, size: 100),
      ),
      drawer: Drawer(),
      body: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              "NETFLIXSTACULAR",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: netflixRed,
                fontSize: 50,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(animation.value, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: RaisedButton(
                        color: netflixRed,
                        onPressed: () {
                          animController.forward();
                        },
                        child: Text(
                          "Reveal Star of the Night Winner\n(Female Category)",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: RaisedButton(
                      color: Colors.white,
                      onPressed: () {},
                      child: Text(
                        "Reveal Star of the Night Winner\n(Male Category)",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 0, 0, 15),
              child: Text(
                "Trending Now",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.368,
              child: MovieListView(),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class MovieListView extends StatefulWidget {
  final list = [
    "assets/ndph1.jpg",
    "assets/ndph2.jpg",
    "assets/ndph3.jpg",
    "assets/ndph4.jpg",
  ];

  var selectedIndex = 0;

  setIndex(int index) {
    selectedIndex = index;
  }

  @override
  _MovieListViewState createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  setIndex(int index) {
    setState(() {
      widget.setIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        scrollDirection: Axis.horizontal,
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          return AnimatedContainer(
              child: Opacity(
                opacity: 1,
                child: InkWell(
                  onTap: () {
                    setIndex(index);
                  },
                  child: AspectRatio(
                    aspectRatio: 4 / 5,
                    child: Container(
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(20.0),
                        child:
                            Image.asset(widget.list[index], fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ),
              curve: Curves.easeOut,
              duration: Duration(milliseconds: 200));
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 20,
          );
        });
  }
}

class ImageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[],
    );
  }
}
