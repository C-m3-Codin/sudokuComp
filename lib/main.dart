import 'package:ccedoku/model/Challenge.dart';
import 'package:ccedoku/model/Challenges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ccedoku/service/firestore_service.dart';
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
  String asd = "11";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Firebase.initializeApp();
  }

  // void getData() {
  //   databaseReference.collection("sudok").get().then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((f) => {print("data here is ${f.data()}")});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Challenges chall = Provider.of<Challenges>(context);
    // String asd = a.challenges[a.challenges[a.selected]].sudk;
    // String asd = a.challenges[a.selected].sudk;

    return Scaffold(
        drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: chall.challenges.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: chall.challenges.length + 1,
                    itemBuilder: (BuildContext ctxt, int index) {
                      print("\n\n\n\n\n item with $index");
                      return index == 0
                          ? DrawerHeader(
                              child: CircleAvatar(),
                              // child: Text('Drawer Header'),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(1),
                              // height: 20.0,
                              child: ListTile(
                                tileColor: Colors.grey,
                                onTap: () {
                                  chall.changeSelected(index - 1);
                                  Navigator.pop(context);
                                },
                                leading: Text((index.toString())),
                                title: Text(chall.challenges[index - 1].answ),
                                trailing: Icon(
                                  Icons.not_started_sharp,
                                  color: Colors.red,
                                ),
                              ),
                            );
                    })
                : ListTile(
                    title: Text("Logout"),
                  )),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: chall.received == false
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(asd == "11" ? "something" : asd),
                  RaisedButton(
                    onPressed: () async {
                      print("\n\n\n\nhere");
                      await chall.getChallenges();
                      // FirebaseService a = new FirebaseService();
                      print("\n\n\n\nhere before get entries");
                      // asd = await a.getEntries();
                      print("\n\n\n\nhere after get entries");
                    },
                    child: Text("press"),
                  )
                ],
              )
            : Sudoku());
  }
}

// class SudTest extends StatefulWidget {
//   // String asd;
//   // SudTest({this.asd});
//   @override
//   _SudTestState createState() => _SudTestState();
// }

// class _SudTestState extends State<SudTest> {
//   @override
//   Widget build(BuildContext context) {
//     Challenges chall = Provider.of<Challenges>(context);
//     return Container(
//       child: Text(chall.challenges[1].sudk),
//     );
//   }
// }

class Sudoku extends StatefulWidget {
  // String asd;
  // Sudoku({this.asd});
  @override
  _SudokuState createState() => _SudokuState();
}

class _SudokuState extends State<Sudoku> {
  // final myController = TextEditingController();
  // List<TextEditingController> myCon = new TextEditingController();
  List<TextEditingController> mycon = [
    for (int i = 1; i < 82; i++) TextEditingController()
  ];
  @override
  Widget build(BuildContext context) {
    Challenges chall = Provider.of<Challenges>(context);
    String asd = chall.challenges[chall.selected].sudk;
    print("\n\n\n\n\n\n\n\nbaaammmmmmm Here\n\n\n\n\n\n\n\n");
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        children: [
          Card(
            child: Text(chall.challenges[chall.selected].answ),
          ),
          Container(
            padding: EdgeInsets.all(2),
            color: Colors.red,
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: List.generate(9, (index) {
                // int index = ind + 1;
                return Container(
                  padding: EdgeInsets.all(1),
                  color: Colors.black,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    children: List.generate(9, (inde) {
                      // int index = ind + 1;
                      return Container(
                        child: Text(asd[inde + index * 9]),
                        color: Colors.blue,
                      );
                    }),
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          RaisedButton(
              color: Colors.green,
              child: Text("Submit"),
              onPressed: () {
                String anss = "";
                // mycon[1]
                for (int i = 0; i < 30; i++) {
                  print("bam\n\n\n");
                  print(mycon[i].text.isEmpty);
                  if (mycon[i].text.isNotEmpty) {
                    anss = anss + mycon[i].text;
                  }
                }

                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(content: Text(anss));
                    });
              })
        ],
      ),
    );
    // });
  }
}
