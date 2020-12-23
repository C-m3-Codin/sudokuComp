import 'package:ccedoku/Widget/Drawer.dart';
// import 'package:ccedoku/Widget/Sudukgrid.dart';
import 'package:ccedoku/Widget/Suduku.dart';
// import 'package:ccedoku/model/Challenge.dart';
import 'package:ccedoku/model/Challenges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:ccedoku/service/firestore_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => Challenges(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String title;
  MyHomePage({this.title});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final databaseReference = FirebaseFirestore.instance;
  // String asd = "11";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    Challenges chall = Provider.of<Challenges>(context);

    return Scaffold(
        drawer: SudDrawer(),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: chall.received == false ? StartGame(chall: chall) : Sudoku());
  }
}

class StartGame extends StatelessWidget {
  const StartGame({
    Key key,
    // @required this.asd,
    @required this.chall,
  }) : super(key: key);

  // final String asd;
  final Challenges chall;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(asd == "11" ? "something" : asd),
              Text("Start Game"),
              RaisedButton(
                onPressed: () async {
                  print("\n\n\n\nhere");
                  await chall.getChallenges();
                },
                child: Text("press"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
