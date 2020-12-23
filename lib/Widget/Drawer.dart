import 'package:ccedoku/model/Challenges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SudDrawer extends StatelessWidget {
  const SudDrawer({
    Key key,
    // @required this.chall,
  }) : super(key: key);

  // final Challenges chall;

  @override
  Widget build(BuildContext context) {
    Challenges chall = Provider.of<Challenges>(context);
    return Drawer(
        child: chall.challenges.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: chall.challenges.length + 1,
                itemBuilder: (BuildContext ctxt, int index) {
                  print("\n\n\n\n\n item with $index");
                  print("${chall.selected}");
                  print(" index runtime ${index.runtimeType}");
                  print("selected runbtue ${chall.selected.runtimeType}");
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
                            tileColor: chall.selected == (index - 1)
                                ? Colors.grey
                                : Colors.amber,
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
              ));
  }
}
