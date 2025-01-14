// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:note_app/controller/note_screen_controller.dart';
import 'package:note_app/view/splash_screen/note_screen/widgets/note_card.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int selectedClrIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          itemBuilder: (context, index) => NoteCard(
                title: NoteScreenController.noteList[index]["title"],
                date: NoteScreenController.noteList[index]["date"],
                clrIndex: NoteScreenController.noteList[index]["colorIndex"],
                des: NoteScreenController.noteList[index]["des"],
                onDeletePressed: () {
                  NoteScreenController.deletedNote(index);
                  setState(() {});
                },
                onEditPressed: () {
                  titleController.text =
                      NoteScreenController.noteList[index]["title"];
                  desController.text =
                      NoteScreenController.noteList[index]["des"];
                  dateController.text =
                      NoteScreenController.noteList[index]["date"];
                  int selectedClrIndex =
                      NoteScreenController.noteList[index]["colorIndex"];
                  customBottomSheet(
                      context: context, isEdit: true, index: index);
                },
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
          itemCount: NoteScreenController.noteList.length),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleController.clear();
          desController.clear();
          dateController.clear();
          int selectedClrIndex = 0;

          customBottomSheet(context: context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> customBottomSheet(
      {required BuildContext context, bool isEdit = false, int? index}) {
    return showModalBottomSheet(
        backgroundColor: Colors.grey.shade800,
        isScrollControlled: true,
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (context, bottomSetState) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isEdit ? "Update Note" : "Add Note",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                            hintText: "Title",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: desController,
                        maxLines: 4,
                        decoration: InputDecoration(
                            hintText: "Description",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                            hintText: "Date",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            suffixIcon: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.date_range_rounded,
                                  color: Colors.black,
                                  size: 25,
                                ))),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            4,
                            (index) => InkWell(
                                  onTap: () {
                                    selectedClrIndex = index;
                                    bottomSetState(() {});
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: selectedClrIndex == index
                                                ? 5
                                                : 0),
                                        borderRadius: BorderRadius.circular(10),
                                        color: NoteScreenController
                                            .coloList[index]),
                                  ),
                                )),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              if (isEdit == true) {
                                NoteScreenController.editNotes(
                                    index: index!,
                                    title: titleController.text,
                                    date: dateController.text,
                                    des: desController.text,
                                    clrIndex: selectedClrIndex);
                              } else {
                                NoteScreenController.addNote(
                                    title: titleController.text,
                                    date: dateController.text,
                                    des: desController.text,
                                    clrIndex: selectedClrIndex);
                              }
                              Navigator.pop(context);
                              setState(() {});
                            },
                            child: Container(
                              width: 100,
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: Text(
                                  isEdit == true ? "Edit" : "Add",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 100,
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}



//notecard