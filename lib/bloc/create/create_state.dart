
import 'package:bloc_pattern2/model/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


@immutable
abstract class CreateState extends Equatable{

}

class CreateInitialState extends CreateState{
  @override
  List<Object?> get props => [];
}

class CreateLoadingState extends CreateState{
  @override
  List<Object?> get props => [];
}

class CreateErrorState extends CreateState{
   final String errorMesage;
   CreateErrorState(this.errorMesage);
   @override
  List<Object?> get props => [];
}

class CreatedPostState extends CreateState{
  final Post post;
  CreatedPostState(this.post);

  @override
  List<Object?> get props => [post];
}


