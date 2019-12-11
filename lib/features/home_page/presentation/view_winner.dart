import 'dart:async';
import 'dart:convert';
import 'package:flutter/scheduler.dart';

import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewWinnerPage extends StatefulWidget {
  final String type;
  Function goBack;

  ViewWinnerPage(this.type, this.goBack);

  @override
  _ViewWinnerPageState createState() => _ViewWinnerPageState();
}

class _ViewWinnerPageState extends State<ViewWinnerPage>
    with SingleTickerProviderStateMixin {
  var url = 'http://xmasbot.us.openode.io/getVoteWinnerTop?VoteType=';
  var text = "Loading...";
  var isLoading = false;
  Timer timer;

  final messages1 = [
    "booting windows 98 VM...",
    "running some scripts... Uh oh!",
    "Building.",
    "Building..",
    "Building...anticipation",
    "wait for it...!",
    "aaaaaaand the winner is!!",
  ];

  getWinner() async {
    isLoading = true;
    var response = await http.get(url + widget.type);
    var jsonMap = json.decode(response.body.toString());

    var i = 0;

    timer = Timer.periodic(Duration(milliseconds: 500), (Timer timer) {
      // if(timer.tick <= messages1.length) {
      //   setState(() {
      //     text = messages1[i++];
      //   });
      // } else {

      // }

      if (timer.tick == 1) {
        setState(() {
          text = widget.type == "starf"
              ? "starting windows 98 VM!"
              : "here we go again!";
        });
      }

      if (timer.tick == 3) {
        setState(() {
          text = widget.type == "starf"
              ? "running some scripts! Uh oh!"
              : "running some scripts again! Uh oh!";
        });
      }

      if (timer.tick == 5) {
        setState(() {
          text = "Building.";
        });
      }

      if (timer.tick == 6) {
        setState(() {
          text = "Building..";
        });
      }

      if (timer.tick == 7) {
        setState(() {
          text = "Building...";
        });
      }

      if (timer.tick == 8) {
        setState(() {
          text = "Building...anticipation";
        });
      }

      if (timer.tick == 10) {
        setState(() {
          text =
              widget.type == "starf" ? "wait for it..." : "wait for it again!";
        });
      }

      if (timer.tick == 13) {
        setState(() {
          text = "aaaaaaand the winner is!!";
        });
      }

      if (timer.tick == 15) {
        setState(() {
          text = jsonMap["score"] + " - " + jsonMap["email"];
          isLoading = false;
        });
        timer.cancel();
      }
    });

    // Timer(Duration(seconds: 3), () {
    //   setState(() {
    //     text = jsonMap["score"] + " - " + jsonMap["email"];
    //     isLoading = false;
    //   });
    // });
  }

  @override
  void initState() {
    getWinner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          Visibility(
            visible: isLoading,
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          Visibility(
            visible: isLoading == false,
            child: Column(
              children: <Widget>[
                // CircleAvatar(
                //   backgroundImage: NetworkImage(
                //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7wil-aq047k9IPWEabcVVHJrJluvg5MaXBUJ6GmMCgGB8CkEA&s"),
                //   radius: 80,
                // ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "NAME",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Visibility(
            child: Theme(
              data: ThemeData(accentColor: netflixRed),
              child: CircularProgressIndicator(),
            ),
            visible: isLoading,
          ),
          Spacer(),
          Container(
            height: 100,
            width: 150,
            child: Visibility(
              visible: isLoading == false,
              child: RaisedButton(
                color: netflixRed,
                onPressed: isLoading
                    ? null
                    : () {
                        widget.goBack();
                      },
                child: Text(
                  "Go Back",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
