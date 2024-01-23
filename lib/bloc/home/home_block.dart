import 'package:bloc_pattern2/bloc/create/create_bloc.dart';
import 'package:bloc_pattern2/bloc/home/home_state.dart';
import 'package:bloc_pattern2/bloc/update/update_bloc.dart';
import 'package:bloc_pattern2/pages/create_page.dart';
import 'package:bloc_pattern2/pages/update_page.dart';
import 'package:bloc_pattern2/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/post_model.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<LoadPostsEvent>(_onLoadPosts);
    on<DeletePostEvent>(_onDeletePost);
  }

  Future<void> _onLoadPosts(LoadPostsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      final posts = Network.parsePostList(response);
      emit(HomePostListState(posts));
    } else {
      emit(HomeErrorState("Couldn't fetch posts"));
    }
  }

  Future<void> _onDeletePost(DeletePostEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final response = await Network.DELATE(
        Network.API_DELATE + event.post.id.toString(), Network.paramsEmpty());
    if (response != null) {
      emit(HomeDelatePostState());
    } else {
      emit(HomeErrorState("Couldn't delete post"));
    }
  }

  void callCreatePage(BuildContext context) async {
   var results=await Navigator.of(context).push(MaterialPageRoute(
       builder: (context)=>BlocProvider(
       create: (context)=>CreateBloc(),
       child: const CreatePage(),
       )));
    if(results !=null){
      add(LoadPostsEvent());
    }
  }

  void callUpdatePage(BuildContext context,Post post) async {
    var results = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            BlocProvider(
              create: (context) => UpdateBloc(),
              child: UpdatePage(post: post),
            )));
    if (results != null) {
      add(LoadPostsEvent());
    }
  }
}
