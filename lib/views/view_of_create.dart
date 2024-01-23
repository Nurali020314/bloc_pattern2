
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/post_model.dart';

Widget viewOfCreate(
    bool isLoading,
    BuildContext context,
    TextEditingController titleController,
    TextEditingController bodyController) {
  return Container(
    padding: EdgeInsets.all(30),
    child: Stack(
      children: [
        Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  hintText: "Title", hintStyle:TextStyle(color: Colors.grey)
              ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(
                  hintText: "Body", hintStyle:TextStyle(color: Colors.grey)
              ),
            ),
            const SizedBox(height: 10,),
            MaterialButton(
                color: Colors.blue,
                child: const Text("Create  a Post",style: TextStyle(color: Colors.white),),
                onPressed: (){
                  String title=titleController.text.toString().trim();
                  String body=bodyController.text.toString().trim();
                  Post post=Post( title:"Nurali", body:"Rasuljonov",userId: 1);
                 // BlocProvider.of<CreatePostCubit>(context).apiPostCreate(post);
                })
          ],
        ),
        isLoading? const Center(
          child: CircularProgressIndicator(),
        ):SizedBox.shrink()
      ],
    ),
  );
}
