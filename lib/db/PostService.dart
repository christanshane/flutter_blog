import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/models/post.dart';

class PostService{
  String nodeName = "posts";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  Map post;

  PostService(this.post);

  addPost(){
    _databaseReference = database.reference().child(nodeName);
    _databaseReference.push().set(post);
  }
}