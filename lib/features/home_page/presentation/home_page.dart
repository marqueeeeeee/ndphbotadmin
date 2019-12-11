import 'package:flutter/material.dart';
import 'package:ndph_xmas_admin/features/home_page/presentation/view_winner.dart';

const netflixRed = Color.fromARGB(255, 229, 9, 20);

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

class __HomePageViewState extends State<_HomePageView> {

  var viewhomepage = true;   
  var type = "";
  var fromGoBack = false;

  changeView(String type) { 
    setState(() {
      this.type = type;
      viewhomepage = false;
    });
  }

  goBack() {
    setState(() {
      fromGoBack = true;
      this.type = "";
      viewhomepage = true;
    });
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
      body: viewhomepage ? _homeView(changeView, fromGoBack) : ViewWinnerPage(type, goBack));
  }
}

class _homeView extends StatefulWidget {

  final Function changeView;
  bool fromGoBack;

  _homeView(this.changeView, this.fromGoBack);

  @override
  __homeViewState createState() => __homeViewState();
}

class __homeViewState extends State<_homeView> with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<double> animation;
  Animation<double> animation2;
  var type = "";

  @override
  void initState() {
    super.initState();

    
    animController = AnimationController(duration: Duration(seconds: 1), vsync: this);

    begin(back: widget.fromGoBack);
  }

  begin({back = false}) {

    double begin = 0;
    double end = -500;

    if(widget.fromGoBack && back) {
      begin = -500;
      end = 0;
    }

    var curveAnimation = CurvedAnimation(parent: animController, curve: Curves.fastOutSlowIn);

    animation = Tween<double>(begin: begin, end: end).animate(curveAnimation)
      ..addListener(() {
        setState(() {});
      })..addStatusListener((enumType) {
      switch(enumType) {

        case AnimationStatus.dismissed:
          // TODO: Handle this case.
          // animController.forward();
          widget.changeView(type);
          break;
        case AnimationStatus.forward:
          // TODO: Handle this case.
          break;
        case AnimationStatus.reverse:
          // TODO: Handle this case.
          break;
        case AnimationStatus.completed:
          // TODO: Handle this case.
          // animController.reverse();
          if(back == false) widget.changeView(type);
          break;
      }
    });

    animation2 = Tween<double>(begin: begin * -1, end: end * -1).animate(curveAnimation)
      ..addListener(() {
        setState(() {});
      })..addStatusListener((enumType) {
      switch(enumType) {

        case AnimationStatus.dismissed:
          // TODO: Handle this case.
          // animController.forward();
          break;
        case AnimationStatus.forward:
          // TODO: Handle this case.
          break;
        case AnimationStatus.reverse:
          // TODO: Handle this case.
          break;
        case AnimationStatus.completed:
          // TODO: Handle this case.
          // animController.reverse();
          break;
      }
    });

    if(widget.fromGoBack && back) {
      animController.forward();
    }
  }

  void displayWinner() {
    animController.forward();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[            
            Container(
              height: 150,
              child: Transform.translate(
                offset: Offset(0, animation.value * 0.5),
                child: Image.asset(
                  "assets/logo.png",
                  scale: 2,
                  
                ),
              ),
            ),
            SizedBox(height: 30,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(animation.value * 1.5, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: RaisedButton(
                        color: netflixRed,
                        onPressed: () {
                          setState(() {
                            type = "starf";
                          });

                          if(widget.fromGoBack) {
                            widget.fromGoBack = false;
                            animController.reverse();
                          } else animController.forward();
                          
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
                  Transform.translate(
                    offset: Offset(animation2.value * 1.5 , 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: RaisedButton(
                        color: Colors.white,
                        onPressed: () {
                          setState(() {                            
                            type = "starm";
                          });

                          if(widget.fromGoBack) {
                            widget.fromGoBack = false;
                            animController.reverse();
                          } else animController.forward();
                          
                        },
                        child: Text(
                          "Reveal Star of the Night Winner\n(Male Category)",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Transform.translate(
              offset: Offset(animation.value * 2, 0),
              child: Container(
                margin: EdgeInsets.fromLTRB(30, 0, 0, 15),
                child: Text(
                  "Trending Now",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Transform.translate(
              offset: Offset(0, animation2.value * 0.7),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.368,
                child: MovieListView(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
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
