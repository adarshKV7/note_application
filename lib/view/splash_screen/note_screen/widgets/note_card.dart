// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:note_app/controller/note_screen_controller.dart';
import 'package:note_app/core/contsatnts/color_constants.dart';
import 'package:note_app/view/splash_screen/note_screen/note_screen.dart';

class NoteCard extends StatelessWidget {
  const NoteCard(
      {super.key,
      required this.title,
      required this.clrIndex,
      required this.date,
      required this.des,
      this.onDeletePressed,
      this.onEditPressed});
  final String title;
  final String des;
  final String date;
  final int clrIndex;
  final void Function()? onDeletePressed;
  final void Function()? onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: NoteScreenController.coloList[clrIndex],
          borderRadius: BorderRadius.circular(13)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Row(
                children: [
                  InkWell(onTap: onEditPressed, child: Icon(Icons.edit)),
                  SizedBox(width: 15),
                  InkWell(onTap: onDeletePressed, child: Icon(Icons.delete))
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(des),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text(date), SizedBox(width: 20), Icon(Icons.share)],
          )
        ],
      ),
    );
  }
}
