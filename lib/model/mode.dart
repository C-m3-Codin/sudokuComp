import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Person {
  final String id;
  final String name;
  List<String> answers;

  Person({this.id, this.answers, this.name});

  factory Person.fromMap(Map data) {
    return Person(name: data['name'], id: data['id']);
  }
}

class Sudok {
  String order;
  String numbers;

  Sudok({this.numbers, this.order});

  factory Sudok.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return Sudok(order: data['order'], numbers: data['numbs']);
  }
}
