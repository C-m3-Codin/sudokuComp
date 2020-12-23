import 'package:ccedoku/Widget/Sudukgrid.dart';
import 'package:ccedoku/model/Challenges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Sudoku extends StatefulWidget {
  // String asd;
  // Sudoku({this.asd});
  @override
  _SudokuState createState() => _SudokuState();
}

class _SudokuState extends State<Sudoku> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

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
          TimerHEre(stopWatchTimer: _stopWatchTimer, isHours: _isHours),
          Card(
            child: Text(chall.challenges[chall.selected].name),
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

                _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                chall.received = "done";
                chall.allOver();
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(content: Text("Thanks for playing"));
                    });

                // chall.received = "done";
              })
        ],
      ),
    );
    // });
  }
}

class TimerHEre extends StatelessWidget {
  const TimerHEre({
    Key key,
    @required StopWatchTimer stopWatchTimer,
    @required bool isHours,
  })  : _stopWatchTimer = stopWatchTimer,
        _isHours = isHours,
        super(key: key);

  final StopWatchTimer _stopWatchTimer;
  final bool _isHours;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: StreamBuilder<int>(
          stream: _stopWatchTimer.rawTime,
          initialData: _stopWatchTimer.rawTime.value,
          builder: (context, snap) {
            final value = snap.data;
            final displayTime =
                StopWatchTimer.getDisplayTime(value, hours: _isHours);
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    displayTime,
                    style: const TextStyle(
                        fontSize: 10,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
