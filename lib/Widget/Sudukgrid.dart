import 'package:flutter/material.dart';

class SudukoGrid extends StatelessWidget {
  const SudukoGrid({
    Key key,
    @required this.asd,
  }) : super(key: key);

  final String asd;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                return !(asd[inde + index * 9] == "a")
                    ? Container(
                        child: Text(asd[inde + index * 9]),
                        color: Colors.blue,
                      )
                    : Container(
                        child: Text(asd[inde + index * 9]),
                        color: Colors.grey,
                      );
              }),
            ),
          );
        }),
      ),
    );
  }
}
