import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/post.dart';
import 'add_post.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  List<Post> postList = <Post>[];
  String nodeName = "posts";

  @override
  void initState() {
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Blog"),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
        ),
        body: Container(
          color: Colors.black87,
          child: Column(
            children: <Widget>[
              Visibility(
                visible: postList.isEmpty,
                child: Center(
                  child: Text("List is empty"),
                ),
              ),
              Visibility(
                visible: postList.isNotEmpty,
                child: Flexible(
                  child: FirebaseAnimatedList(
                      query: _database.reference().child(nodeName),
                      itemBuilder: (_, DataSnapshot snap,
                          Animation<double> animation, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: ListTile(
                              title: Text(
                                postList[index].title,
                                style: TextStyle(
                                    fontSize: 22.0, fontWeight: FontWeight.bold),
                              ),
                              trailing: Text("a minute ago"),
                              subtitle: Text(postList[index].body),
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddPost()));
          },
          child: Icon(
            Icons.create,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          tooltip: "Create Post",
        ));
  }

  _childAdded(Event event) {
    setState(() {
      postList.add(Post.fromSnapshot(event.snapshot));
    });
  }
}
