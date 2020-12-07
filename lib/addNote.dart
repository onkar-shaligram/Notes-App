import 'package:flutter/material.dart';

class AddNote extends StatelessWidget {
  
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {},
            child: Text(
              "Save",
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
                maxLines: null,  //Let this be infinity
                expands: true,   //let this be expanding howoever it want
                decoration: InputDecoration(hintText: "Content"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
