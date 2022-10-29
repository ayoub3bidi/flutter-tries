import 'package:dartz/dartz.dart';
import 'package:flutter_tries/features/posts/domain/repositories/posts_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class UpdatePostUseCase {

  final PostsRepository postsRepository;

  UpdatePostUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> updatePost(Post post) async {
    return await postsRepository.updatePost(post);
  }
}