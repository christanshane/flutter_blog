import 'package:flutter/material.dart';
import 'package:flutter_app/db/PostService.dart';
import 'package:flutter_app/models/post.dart';
import 'home.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final GlobalKey<FormState> formKey = new GlobalKey();
  Post post = Post(0,"","");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Post"),
          elevation: 0.0,
        ),
        body:Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Title",
                    ),
                    onSaved: (val)=> post.title = val,
                    validator: (val){
                      if(val.isEmpty){
                        return "This field can't be empty!";
                      }else if(val.length>16){
                        return "This cannot be more than 16 characters";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Body"
                    ),
                    onSaved: (val)=>post.body = val,
                    validator: (val){
                      if(val.isEmpty){
                        return "This field can't be empty!";
                      }
                    },
                  ),
                ),
              ],
            )),
        floatingActionButton: FloatingActionButton(onPressed: (){
          insertPost();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
        },
          child: Icon(Icons.save, color: Colors.white,),
          backgroundColor: Colors.red,
          tooltip: "Save Post",
        )
    );
  }

  void insertPost() {
    final FormState form = formKey.currentState;
    if(form.validate()){
      form.save();
      form.reset();
      post.date = DateTime.now().millisecondsSinceEpoch;
      PostService postService = PostService(post.toMap());
      postService.addPost();
    }
  }
}
