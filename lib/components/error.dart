import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorScreen extends StatelessWidget {
  final String error;
  final IconData icon;

  ErrorScreen({
    this.error = 'An unknown error happened',
    this.icon = Icons.mood_bad,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60, right: 20, left: 20),
      width: double.infinity,
      color: Colors.grey.shade100,
      child: Column(
        children: [
          Icon(
            icon,
            size: 150,
            color: Colors.grey,
          ),
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class NetworkError extends ErrorScreen {
  NetworkError()
      : super(
          error: 'The server is unreachable. Are you connected to the internet ?',
          icon: Icons.wifi_off,
        );
}
