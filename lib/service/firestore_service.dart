import 'package:ccedoku/model/Challenge.dart';
import 'package:ccedoku/model/Challenges.dart';
import 'package:ccedoku/model/mode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/physics.dart';

class FirebaseService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // get

  getEntriesAll() async {
    // String ap = "";
    List<Challege> lisChal = [];
    await _db.collection("sudok").get().then((value) => {
          print("\n\n\n\n\n\n\neach document"),
          // ap = value.data().values.toString(),
          print("\n\n\n\n\n${value.runtimeType}"),
          value.docs.forEach((element) {
            // element.toString();
            // print("\n\n\n\n\n ${element}");

            element.data().forEach((key, value) {
              print("\n\n\n\nvalues is ${value.toString()}");
              var a = Challege(done: false, answ: key, sudk: value);
              lisChal.add(a);
            });
          })
          // print(" bam aaaa ${ap.length}")
        });

    // print("\n\n\\n befire return ${ap.length}");
    // print("\n\n\n\n${ap.runtimeType}\n\n\n");
    return lisChal;
  }

  // getEntries() async {
  //   await _db.collection("sudok").doc("challenges").get().then((value) => {
  //         value.data().forEach((key, value) {
  //           var a = Challege(sudk:);
  //           print("\n\n\n\nvalues in get entries is + $value ");
  //         })
  //       });
  // }

  Future<Person> getPers(String id) async {
    DocumentSnapshot snap = await _db.collection("Person").doc(id).get();
    return Person.fromMap(snap.data());
  }

  // get stream

  Stream<Person> streamPers(String id) {
    return _db
        .collection("Person")
        .doc(id)
        .snapshots()
        .map((event) => Person.fromMap(event.data()));
  }

  Stream<List<Sudok>> streamSudokus() {
    // var ref=_db.collections
  }

  // insert

  // update

  // de;ete
}
