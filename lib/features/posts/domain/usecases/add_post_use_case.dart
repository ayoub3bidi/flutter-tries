import 'package:dartz/dartz.dart';
import 'package:flutter_tries/core/error/failures.dart';
import 'package:flutter_tries/features/posts/domain/entities/post.dart';
import 'package:flutter_tries/features/posts/domain/repositories/posts_repository.dart';

class AddPostUseCase {

  final PostsRepository postsRepository;

  AddPostUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> addPost(Post post) async{
    return await postsRepository.addPost(post);
  }
}