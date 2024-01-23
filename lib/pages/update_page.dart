import 'package:bloc_pattern2/bloc/update/update_bloc.dart';
import 'package:bloc_pattern2/bloc/update/update_event.dart';
import 'package:bloc_pattern2/bloc/update/update_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/post_model.dart';

class UpdatePage extends StatefulWidget {
  final Post? post;

  const UpdatePage({Key? key, required this.post}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late UpdateBloc updateBloc;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.post!.title.toString();
    bodyController.text = widget.post!.body.toString();

    updateBloc = BlocProvider.of<UpdateBloc>(context);
    updateBloc.stream.listen((state) {
      if (state is UpdatePostState) {
        _finish(context);
      }
      if (state is UpdateErrorState) {}
    });
  }

  _finish(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Navigator.pop(context, "result");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Post"),
      ),
      body: BlocBuilder<UpdateBloc,UpdateState>(
        builder: (BuildContext context,UpdateState state){
          if(state is UpdateLoadingState){
            return viewOfUpdate(true,context,titleController,bodyController);
          }
          return viewOfUpdate(false,context,titleController,bodyController);
        },
      ),
    );
  }

  Widget viewOfUpdate(
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
                  child: const Text("Update a Post",style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    String title=titleController.text.toString().trim();
                    String body=bodyController.text.toString().trim();
                    Post post=Post(
                      id:widget.post!.id,
                      title:title,
                      body: body,
                      userId: widget.post!.userId,
                    );
                    updateBloc.add(UpdatePostEvent(post: post));
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

}
