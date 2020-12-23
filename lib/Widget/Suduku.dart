import 'package:ccedoku/Widget/Sudukgrid.dart';
import 'package:ccedoku/model/Challenges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          Container(
            child: Card(
              elevation: 20.0,
              child: Text("bam"),
            ),
          ),
          Card(
            child: Text(chall.challenges[chall.selected].answ),
          ),
          SudukoGrid(asd: asd),
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
