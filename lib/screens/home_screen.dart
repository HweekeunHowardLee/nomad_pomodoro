import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const defaultSeconds = 100;
  int totalSeconds = defaultSeconds;
  int totalPomodoro = 0;
  bool timerOn = false;
  double _seconds = 30;
  late Timer timer;

  void countDown(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoro = totalPomodoro + 1;
        totalSeconds = defaultSeconds;
        timerOn = false;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(Duration(seconds: 1), countDown);
    setState(() {
      timerOn = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      timerOn = false;
    });
  }

  void onRefreshPressed() {
    setState(() {
      totalSeconds = defaultSeconds;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: IconButton(
                    onPressed: timerOn ? onPausePressed : onStartPressed,
                    icon: Icon(timerOn
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_fill_rounded),
                    iconSize: 100,
                    color: Theme.of(context).cardColor,
                    hoverColor: Colors.lime,
                  ),
                ),
                Center(
                  child: IconButton(
                    onPressed: onRefreshPressed,
                    icon: Icon(Icons.refresh),
                    iconSize: 100,
                    color: Theme.of(context).cardColor,
                    hoverColor: Colors.lime,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Slider(
              value: _seconds,
              min: 0,
              max: 300, // Adjust the maximum duration as needed
              divisions: 300, // Make it increments by 1
              activeColor: Colors.grey[800],
              onChanged: (double value) {
                setState(() {
                  totalSeconds = value.toInt();
                  _seconds = value;
                });
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodoros",
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .color,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            fontStyle: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .fontStyle,
                          ),
                        ),
                        Text(
                          "$totalPomodoro",
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .color,
                            fontWeight: FontWeight.w500,
                            fontSize: 40,
                            fontStyle: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .fontStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
