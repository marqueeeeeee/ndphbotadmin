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

  getWinner() async {
    isLoading = true;
    var response = await http.get(url + widget.type);
    var jsonMap = json.decode(response.body.toString());

    Timer.periodic(Duration(milliseconds: 1500), (Timer timer) {
      if (timer.tick == 1) {
        setState(() {
          text = widget.type == "starf" ? "generating windows 98 VM!" : "here we go again!";
        });
      } else if (timer.tick == 2) {
        setState(() {
          text = widget.type == "starf" ? "running some scripts! Uh oh!" : "running some scripts again! Uh oh again!";
        });
      } else if (timer.tick == 3) {
        setState(() {
          text = widget.type == "starf" ? "wait for it! Building - anticipation" : "wait for it again!";
        });
      } else if (timer.tick == 4) {
        setState(() {
          text = "aaaaaaand the winner is!!";
        });
      } else
        setState(() {
          text = jsonMap["score"] + " - " + jsonMap["email"];
          isLoading = false;
        });
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
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 30),
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
