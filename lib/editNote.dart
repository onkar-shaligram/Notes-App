import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  DocumentSnapshot docToEdit;

  EditNote(
      {this.docToEdit}); // The document which has to be edited is passed out through this constructor.

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  @override
  Widget build(BuildContext context) {
    TextEditingController title =
        TextEditingController(text: widget.docToEdit.data()['title']);
    TextEditingController content =
        TextEditingController(text: widget.docToEdit.data()['content']);

    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {
              widget.docToEdit.reference.update({
                'title': title.text,
                'content': content.text,
              }).whenComplete(() => Navigator.pop(context));
            },
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
          FlatButton(
            onPressed: () {
              widget.docToEdit.reference
                  .delete()
                  .whenComplete(() => Navigator.pop(context));
            },
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(border: Border.all()),
            child: TextField(
              controller: title,
              decoration: InputDecoration(hintText: "Title"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: content,
                maxLines: null, //Let this be infinity
                expands: true, //let this be expanding howoever it want
                decoration: InputDecoration(hintText: "Content"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
