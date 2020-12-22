import 'package:ccedoku/model/Challenge.dart';
import 'package:ccedoku/service/firestore_service.dart';
import 'package:flutter/material.dart';

class Challenges with ChangeNotifier {
  List<Challege> challenges = [];
  // String data;
  FirebaseService a = new FirebaseService();
  bool received = false;

  getChallenges() async {
    challenges = await a.getEntriesAll();
    print(
        "\n\n\n\n\n\nreceived challenges and their len is ${challenges.length}\n\n ");
    received = true;
    // print("data is $data");
    notifyListeners();
  }
}
