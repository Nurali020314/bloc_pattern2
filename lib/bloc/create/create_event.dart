
import 'package:bloc_pattern2/model/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class CreateEvent extends Equatable {
  const CreateEvent();
}

class CreatePostEvent extends CreateEvent{
  final Post post;
  const CreatePostEvent({ required this.post});
  @override
  List<Object?> get props => [post];
}