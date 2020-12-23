import 'package:ccedoku/model/Challenge.dart';
import 'package:ccedoku/service/firestore_service.dart';
import 'package:flutter/material.dart';

class Challenges with ChangeNotifier {
  List<Challege> challenges = [];
  // String data;
  FirebaseService a = new FirebaseService();
  String received = "NotDone";
  int selected;

  getChallenges() async {
    challenges = await a.getEntriesAll();
    print(
        "\n\n\n\n\n\nreceived challenges and their len is ${challenges.length}\n\n ");
    received = "Done";
    selected = 0;
    // print("data is $data");
    notifyListeners();
  }

  changeSelected(int sel) {
    selected = sel;

    print("\n\n\n\n selected $selected \n\n\n\n\n");
    notifyListeners();
  }

  allOver() {
    received = "allOver";
    notifyListeners();
  }
}
