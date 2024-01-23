
import 'package:bloc_pattern2/bloc/create/create_bloc.dart';
import 'package:bloc_pattern2/bloc/create/create_event.dart';
import 'package:bloc_pattern2/bloc/create/create_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/post_model.dart';




class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late CreateBloc createBloc;
  TextEditingController  titleController=TextEditingController();
  TextEditingController  bodyController=TextEditingController();

  @override
  void initState() {
    super.initState();
    createBloc=BlocProvider.of<CreateBloc>(context);
    createBloc.stream.listen((state) {
      if(state is CreatedPostState){
        _finish(context);
      }
      if(state is CreateErrorState){

      }
    });
  }

  _finish(BuildContext context){
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context,"result");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      body: BlocBuilder<CreateBloc,CreateState>(
        builder: (BuildContext context,CreateState state){
          if(state is CreateLoadingState){
            return viewOfCreate(true,context,titleController,bodyController);
          }
          return viewOfCreate(false,context,titleController,bodyController);
        },
      )
    );
  }


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
                    Post post=Post( title:title, body:body,userId: 1);
                    createBloc.add(CreatePostEvent(post: post));
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
