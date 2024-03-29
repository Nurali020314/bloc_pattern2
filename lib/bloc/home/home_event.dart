import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../model/post_model.dart';


@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadPostsEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class DeletePostEvent extends HomeEvent {
  final Post post;
  DeletePostEvent({required this.post});

  @override
  List<Object?> get props => [post];
}
