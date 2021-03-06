import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/addNote.dart';
import 'package:notes_app/editNote.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Notes App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ref = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddNote()));
          },
        ),
        body: StreamBuilder(
            stream: ref.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2), // 2 rows and others are collumns.

                  itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => EditNote(
                                      docToEdit: snapshot.data.docs[index],
                                    )));
                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        height: 130,
                        color: Colors.grey[400],
                        child: Column(
                          children: [
                            Text(snapshot.data.docs[index].data()['title']),
                            Text(snapshot.data.docs[index].data()['content']),
                          ],
                        ),
                      ),
                    );
                  });
            }));
  }
}
