import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siasa/Player.dart';

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
  final Player _player;

  GameScreen(this._player);

  @override
  State<StatefulWidget> createState() {
    return GameScreenState(_player);
  }
}

enum Screens { YOUR_BILLS, ALL_BILLS, VOTE }

class GameScreenState extends State<GameScreen> {
  Player _player;
  Screens _currentScreen = Screens.ALL_BILLS;

  int _currentIndex = 1;
  List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    _children = [yourBillsView(), allBillsScreen(), voteScreen()];
  }

  GameScreenState(this._player);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Hello ${_player.name}"),
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
        child: StreamBuilder(
          stream: Firestore.instance.collection("Users").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                var p = snapshot.data;
                print(p);
                return ListView.builder(
                  itemCount: p.length,
                  itemBuilder: (BuildContext context, i) {
                    return policyCard(
                        p[i], p[i]['description']);
                  },
                );
            }
          },
        ),
      ),
    );
  }

  allBillsScreen() {
    return Container(
      child: Center(
        child: StreamBuilder(
          stream: Firestore.instance.collection("Policies").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                var p = snapshot.data;
                print(p);
                return ListView.builder(
                  itemCount: p.documents.length,
                  itemBuilder: (BuildContext context, i) {
                    return policyCard(
                        p.documents[i]['name'], p.documents[i]['description']);
                  },
                );
            }
          },
        ),
      ),
    );
  }

  policyCard(name, desc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Text(desc),
          ],
        ),
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
