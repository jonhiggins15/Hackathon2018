import 'package:flutter/material.dart';

//class Game extends StatelessWidget{
//
//  final String _name;
//  Game(this._name);
//
//  @override
//  Widget build(BuildContext context) {
//    return GameScreen(_name);
//  }
//
//}

class GameScreen extends StatefulWidget {
  final String _name;

  GameScreen(this._name);

  @override
  State<StatefulWidget> createState() {
    return GameScreenState(_name);
  }
}

enum Screens { YOUR_BILLS, ALL_BILLS, VOTE }

class GameScreenState extends State<GameScreen> {
  String _name;
  Screens _currentScreen = Screens.ALL_BILLS;

  int _currentIndex = 0;
  List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    _children = [yourBillsView(), allBillsScreen(), voteScreen()];
  }

  GameScreenState(this._name);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Hello $_name"),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Your bills'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('All bills'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            title: Text('Vote'),
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  getTab(String s, screen) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentScreen = screen;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text(
                s,
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getTabScreen() {
    switch (_currentScreen) {
      case Screens.YOUR_BILLS:
        return yourBillsView();
      case Screens.ALL_BILLS:
        return allBillsScreen();
      case Screens.VOTE:
        return voteScreen();
    }
  }

  yourBillsView() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text("Your bills"),
          ],
        ),
      ),
    );
  }

  allBillsScreen() {
    return Container(
      child: Center(
        child: Text("All bills"),
      ),
    );
  }

  voteScreen() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Vote"),
            RaisedButton(onPressed: () {}, child: Text("Yes")),
            RaisedButton(onPressed: () {}, child: Text("No")),
            RaisedButton(onPressed: () {}, child: Text("Abstain")),
          ],
        ),
      ),
    );
  }
}
