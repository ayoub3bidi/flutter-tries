part of 'add_delete_update_post_bloc.dart';

abstract class AddDeleteUpdatePostState extends Equatable {
  const AddDeleteUpdatePostState();
  
  @override
  List<Object> get props => [];
}

class AddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {}

class LoadingAddDeleteUpdatePost extends AddDeleteUpdatePostState {}

class ErrorAddDeleteUpdatePost extends AddDeleteUpdatePostState {
  final String message;

  const ErrorAddDeleteUpdatePost({ required this.message});

  @override
  List<Object> get props => [message];

}

class MessageAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
  final String message;

  const MessageAddDeleteUpdatePostState({ required this.message});

  @override
  List<Object> get props => [message];
}
