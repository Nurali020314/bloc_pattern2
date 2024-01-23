import 'package:bloc_pattern2/bloc/create/create_event.dart';
import 'package:bloc_pattern2/bloc/create/create_state.dart';
import 'package:bloc_pattern2/model/post_model.dart';
import 'package:bloc_pattern2/services/http_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc() : super(CreateInitialState()) {
    on<CreatePostEvent>(_onCreatePost);
  }

  Future<void> _onCreatePost(CreatePostEvent event,Emitter<CreateState> emitter) async {
    emit(CreateLoadingState());
    final response=await Network.POST(Network.API_CREAT, Network.paramsCreate(event.post));
    if(response!=null){
      Post post=Network.parsePost(response);
       emit(CreatedPostState(post));
    }else{
      emit(CreateErrorState(" Couldn't create post"));
    }

  }
}

