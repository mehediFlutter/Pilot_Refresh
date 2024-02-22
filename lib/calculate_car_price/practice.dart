import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String taka = '220 Taka', dollar = '2 Dollars';
  bool showTaka = true; // Store state outside the dialog class

  void toggleCurrency() {
    setState(() {
      showTaka = !showTaka;
    });
  }

  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        toggleCurrency();
                      });
                    },
                    child: Text("Change"),
                  ),
                  // Access the state variable directly:
                  Text(showTaka ? taka : dollar),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                openDialog(context);
              },
              child: Text('Open Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}