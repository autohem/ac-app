import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

enum FanStates { Low, Medium, High, Auto, Off }
enum Modes { Auto, Cool, Heate, Fan }
enum AcStates { On, Off }

Widget temperatureWidget(BuildContext context, int temperature,
    Function onIncrease, Function onDecrease) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
              iconSize: 48,
              icon: Icon(
                Icons.arrow_drop_up,
              ),
              onPressed: onIncrease),
          Text(
            '$temperature ºC',
            style: Theme.of(context).textTheme.headline2,
          ),
          IconButton(
              iconSize: 48,
              icon: Icon(Icons.arrow_drop_down),
              onPressed: onDecrease),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 32),
        child: IconButton(
          tooltip: 'Mode',
          icon: Icon(Icons.ac_unit),
          onPressed: () {},
          iconSize: 64,
        ),
      )
    ],
  );
}

Widget fanWidget(BuildContext context, Function onAutoFan, bool autoFanState,
    Color iconColor) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.toys,
              color: iconColor,
            ),
            onPressed: autoFanState ? null : () {},
            iconSize: 64,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 64),
            child: Transform.scale(
              scale: 1.5,
              child: Switch(value: autoFanState, onChanged: onAutoFan),
            ),
          ),
        ],
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _temperature = 17;
  bool _isOn = false;
  bool _autoFan = false;
  Color _onColorStatus = Colors.red[700];
  Color _fanIconColor = Colors.black;

  void _turnOnAc() {
    setState(() {
      if (_isOn) {
        _isOn = false;
        _onColorStatus = Colors.red[700];
      } else {
        _isOn = true;
        _onColorStatus = Colors.green[800];
      }
    });
  }

  void _incrementTemperature() {
    if (_temperature < 31) {
      setState(() {
        _temperature++;
      });
    }
  }

  void _decrementTemperature() {
    if (_temperature > 17) {
      setState(() {
        _temperature--;
      });
    }
  }

  void _onAutoFan(bool state) {
    setState(() {
      _autoFan = state;
      if (state) {
        _fanIconColor = Colors.grey;
      } else {
        _fanIconColor = Colors.black;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Chip(label: Text('offline'), backgroundColor: Colors.red[600]),
            temperatureWidget(context, _temperature, _incrementTemperature,
                _decrementTemperature),
            fanWidget(context, _onAutoFan, _autoFan, _fanIconColor),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _turnOnAc,
        backgroundColor: _onColorStatus,
        tooltip: 'On/Off',
        child: Icon(
          Icons.power_settings_new,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
