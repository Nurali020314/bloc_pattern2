import 'package:bloc_pattern2/bloc/home/home_block.dart';
import 'package:bloc_pattern2/bloc/home/home_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../model/post_model.dart';

Widget itemHomePost(BuildContext context, HomeBloc homeBloc, Post post) {
  return Slidable(
    startActionPane: ActionPane(
      extentRatio: 0.25,
      motion: ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (BuildContext context) {
           homeBloc.callUpdatePage(context, post);
          },
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          icon: Icons.edit,
          label: "Update",
        ),
      ],
    ),
    endActionPane: ActionPane(
      extentRatio: 0.25,
      motion: ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (BuildContext context) {
            homeBloc.add(DeletePostEvent(post: post));
          },
          flex: 3,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: "Delate",
        ),
      ],
    ),
    child: Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title!.toUpperCase(),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(post.body.toString()),
        ],
      ),
    ),
  );
}
