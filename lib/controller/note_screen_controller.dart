import 'package:flutter/material.dart';
import 'package:note_app/core/contsatnts/color_constants.dart';

class NoteScreenController {
  static List noteList = [];

  static List<Color> coloList = [
    ColorConstants.clr1,
    ColorConstants.clr2,
    ColorConstants.clr3,
    ColorConstants.clr4
  ];

  static void addNote({
    required String title,
    required String des,
    required String date,
    int clrIndex = 0,
  }) {
    noteList.add({
      "title": title,
      "des": des,
      "date": date,
      "colorIndex": clrIndex,
    });
  }

  static void deletedNote(int index) {
    noteList.removeAt(index);
  }

  static void editNotes({
    required int index,
    required String title,
    required String des,
    required String date,
    int clrIndex = 0,
  }) {
    noteList[index] = {
      "title": title,
      "des": des,
      "date": date,
      "colorIndex": clrIndex,
    };
  }
}
