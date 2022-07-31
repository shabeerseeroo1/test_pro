import 'package:bloc_rx_dart/presentation/routes/app_routes.dart';
import 'package:bloc_rx_dart/presentation/screens/dash_board.dart';
import 'package:bloc_rx_dart/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getStream().listen((event) {
      print('event is $event');
    });
    var sum = 0;
    getSteam2().listen((event) {
      sum += event;
      print('Sum is $sum');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      routes: {
       AppRoutes.login:(context)=> PositionedTiles(),
        AppRoutes.dashboard:(context)=> const DashboardScreen()
      },
    );
  }
}

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  List<Widget> tiles = [
    StatelessColorfulTile(color: Colors.red),
    StatelessColorfulTile(color: Colors.green,),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: tiles),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.sentiment_very_satisfied), onPressed: swapTiles),
    );
  }

  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}

class StatelessColorfulTile extends StatelessWidget {
  StatelessColorfulTile({Key? key,
    required this.color,
}) : super(key: key);
final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: color, child: Padding(padding: EdgeInsets.all(70.0)));
  }
}

class UniqueColorGenerator {
  Color getColor(){
    return Colors.green;
  }
}

//subscribing stream
Stream<int> getStream() async* {
  for (int i = 1; i <= 10; i++) {
    yield i;
    await Future.delayed(const Duration(seconds: 1));
  }
}

Stream<int> getSteam2() async* {
  for (int i = 1; i <= 3; i++) {
    yield i;
    Future.delayed(const Duration(seconds: 1));
  }
}
Stream<int> getStream3()async*{

  for(int i=1; i<=10; i++){
    yield i;
    await Future.delayed(const Duration(seconds: 1));
  }
}


