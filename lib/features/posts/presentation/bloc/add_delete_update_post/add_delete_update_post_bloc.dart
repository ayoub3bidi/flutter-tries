import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tries/core/error/failures.dart';
import 'package:flutter_tries/core/strings/failure.dart';
import 'package:flutter_tries/core/strings/messages.dart';

import 'package:flutter_tries/features/posts/domain/entities/post.dart';
import 'package:flutter_tries/features/posts/domain/usecases/add_post_use_case.dart';
import 'package:flutter_tries/features/posts/domain/usecases/delete_post_use_case.dart';
import 'package:flutter_tries/features/posts/domain/usecases/update_post_use_case.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUsecase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUsecase updatePostUseCase;

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error, Please Try again later.";
    }
  }

  AddDeleteUpdatePostState eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdatePost(
        message: mapFailureToMessage(failure),
      ),
      (_) => MessageAddDeleteUpdatePostState(message: message),
    );
  }
  
  AddDeleteUpdatePostBloc({
    required this.addPostUseCase,
    required this.deletePostUseCase,
    required this.updatePostUseCase,
    }) : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async{
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePost());
        final failureOrDoneMessage = await addPostUseCase(event.post);
        emit(eitherDoneMessageOrErrorState(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePost());
        final failureOrDoneMessage = await updatePostUseCase(event.post);
        emit(eitherDoneMessageOrErrorState(failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE),
        );
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePost());
        final failureOrDoneMessage = await deletePostUseCase(event.postId);
        emit(eitherDoneMessageOrErrorState(failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      } 
    });
  }
}
