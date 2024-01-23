import 'package:bloc_pattern2/bloc/update/update_event.dart';
import 'package:bloc_pattern2/bloc/update/update_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/post_model.dart';
import '../../services/http_service.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc() : super(UpdateInitialState()) {
    on<UpdatePostEvent>(_onUpdetePost);
  }

  Future<void> _onUpdetePost(
      UpdatePostEvent event, Emitter<UpdateState> emitter) async {
    emit(UpdateLoadingState());
    final response = await Network.PUT(
        Network.API_UPDATE + event.post.id.toString(), Network.paramsUpdate(event.post));
    if (response != null) {
      Post post = Network.parsePost(response);
      emit(UpdatePostState(post));
    } else {
      emit(UpdateErrorState(" Couldn't update post"));
    }
  }
}
