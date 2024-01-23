import 'package:bloc_pattern2/bloc/home/home_block.dart';
import 'package:bloc_pattern2/bloc/home/home_event.dart';
import 'package:bloc_pattern2/model/post_model.dart';
import 'package:bloc_pattern2/views/item_of_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(LoadPostsEvent());
    homeBloc.stream.listen((state) {
      if(state is HomeDelatePostState){
        homeBloc.add(LoadPostsEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BloC 2"),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeErrorState) {
            return viewOfError(state.errorMessage);
          }
          if (state is HomePostListState) {
            return viewOfPostList(state.posts);
          }
          return viewOfLoading();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          homeBloc.callCreatePage(context);
        },
      ),
    );
  }

  Widget viewOfError(String error) {
    return Center(
      child: Text("Error $error"),
    );
  }

  Widget viewOfLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget viewOfPostList(List<Post> items) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, index) {
          Post post = items[index];
          return itemHomePost(context, homeBloc, post);
        });
  }
}
