import 'package:dartz/dartz.dart';
import 'package:flutter_tries/core/error/failures.dart';
import 'package:flutter_tries/features/posts/domain/repositories/posts_repository.dart';

class DeletPostUseCase {

  final PostsRepository postsRepository;

  DeletPostUseCase (this.postsRepository);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await postsRepository.deletePost(postId);
  }
}