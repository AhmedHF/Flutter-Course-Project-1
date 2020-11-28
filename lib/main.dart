import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String displayNum = '0';
  String str = '';
  double firstValue = 0.0;
  double secondValue = 0.0;

  String calcNum = '';
  String operationSymbol = '';
  double result;
  bool shouldCalculate = false;

  void _pressButton(String buttonText) {
    setState(() {
      switch (buttonText) {
        case '+':
        case '-':
        case '*':
        case '/':
        case '%':
          str += buttonText;
          if (shouldCalculate) {
            _calculate();
          } else {
            result = double.tryParse(calcNum) ?? 0;
            shouldCalculate = true;
          }
          calcNum = '';
          operationSymbol = buttonText;

          break;
        case '=':
          _calculate();
          operationSymbol = '';
          shouldCalculate = false;
          break;
        case 'C':
          str = '';
          calcNum = '';
          displayNum = '0';
          operationSymbol = '';
          result = 0;
          shouldCalculate = false;
          break;
        default:
          str += buttonText;
          calcNum += buttonText;
          displayNum = calcNum;
      }
    });
  }

  void _calculate() {
    switch (operationSymbol) {
      case '+':
        result += double.tryParse(calcNum) ?? 0;
        break;
      case '-':
        result -= double.tryParse(calcNum) ?? 0;
        break;
      case '*':
        result *= double.tryParse(calcNum) ?? 0;
        break;
      case '/':
        result /= double.tryParse(calcNum) ?? 0;
        break;
      case '%':
        print("object");
        // print(result as String);
        // print(double.tryParse(calcNum));
        // result.remainder(num.tryParse(calcNum));
        // print("object2222");
        result %= num.tryParse(calcNum) ?? 0;
        break;
      default:
        break;
    }
    if (result.isNaN) result = 0;
    calcNum = result.toString();
    displayNum = calcNum;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                // child: Align(
                // alignment: Alignment.bottomRight,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Wrap(
                        children: <Widget>[
                          Text(
                            str,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Wrap(
                        children: <Widget>[
                          Text(
                            displayNum,
                            style: TextStyle(
                              fontSize: 50.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  _buttonRow('C', '%', '', '/'),
                  _buttonRow('7', '8', '9', '*'),
                  _buttonRow('4', '5', '6', '-'),
                  _buttonRow('1', '2', '3', '+'),
                  _buttonRow('00', '0', '.', '='),
                ],
              ),
            )
          ],
        ),
      ),
      // body: Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: Container(
      //     margin: EdgeInsets.all(32),
      //     child: Column(
      //       // Column is also a layout widget. It takes a list of children and
      //       // arranges them vertically. By default, it sizes itself to fit its
      //       // children horizontally, and tries to be as tall as its parent.
      //       //
      //       // Invoke "debug painting" (press "p" in the console, choose the
      //       // "Toggle Debug Paint" action from the Flutter Inspector in Android
      //       // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
      //       // to see the wireframe for each widget.
      //       //
      //       // Column has various properties to control how it sizes itself and
      //       // how it positions its children. Here we use mainAxisAlignment to
      //       // center the children vertically; the main axis here is the vertical
      //       // axis because Columns are vertical (the cross axis would be
      //       // horizontal).
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         Row(
      //           children: <Widget>[
      //             Expanded(
      //               flex: 2,
      //               child: TextField(
      //                 onChanged: (v) {
      //                   firstValue = double.parse(v);
      //                 },
      //                 keyboardType: TextInputType.number,
      //                 decoration: InputDecoration(
      //                   hintText: "first number",
      //                 ),
      //               ),
      //             ),
      //             Expanded(flex: 1, child: Icon(Icons.add)),
      //             Expanded(
      //               flex: 2,
      //               child: TextField(
      //                 onChanged: (v) {
      //                   secondValue = double.parse(v);
      //                 },
      //                 keyboardType: TextInputType.number,
      //                 decoration: InputDecoration(
      //                   hintText: "second number",
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //         Container(
      //           margin: EdgeInsets.symmetric(vertical: 16),
      //           child: RaisedButton(
      //             child: Text(
      //               '=',
      //               style: TextStyle(color: Colors.white, fontSize: 25),
      //             ),
      //             onPressed: () {
      //               setState(() {
      //                 result = firstValue + secondValue;
      //               });
      //             },
      //             color: Colors.blue,
      //           ),
      //         ),
      //         Text(
      //           'Result: $result',
      //           style: TextStyle(fontSize: 19),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      // // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _calcuButton(String buttonText) {
    return Expanded(
      child: ButtonTheme(
        height: double.infinity,
        child: OutlineButton(
          onPressed: () => _pressButton(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          splashColor: Theme.of(context).primaryColor.withOpacity(0.1),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
          ),
          highlightedBorderColor:
              Theme.of(context).primaryColor.withOpacity(0.1),
        ),
      ),
    );
  }

  Widget _buttonRow(String firstButton, String secondButton, String thirdButton,
      String fourthButton) {
    return Expanded(
      child: Row(
        children: <Widget>[
          _calcuButton(firstButton),
          _calcuButton(secondButton),
          _calcuButton(thirdButton),
          _calcuButton(fourthButton),
        ],
      ),
    );
  }
}
