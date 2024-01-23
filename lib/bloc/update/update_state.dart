
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


import '../../model/post_model.dart';

@immutable
abstract class UpdateState extends Equatable{}

class UpdateInitialState extends UpdateState{
  @override
  List<Object?> get props => [];
}

class UpdateLoadingState extends UpdateState{
  @override
  List<Object?> get props => [];
}

class UpdateErrorState extends UpdateState{
  final String errorMesage;
  UpdateErrorState(this.errorMesage);
  @override
  List<Object?> get props => [];
}

class UpdatePostState extends UpdateState{
  final Post post;
  UpdatePostState(this.post);

  @override
  List<Object?> get props => [post];
}


