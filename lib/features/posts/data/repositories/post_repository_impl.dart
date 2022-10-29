import 'package:flutter_tries/core/error/exceptions.dart';
import 'package:flutter_tries/core/network/network_info.dart';
import 'package:flutter_tries/features/posts/data/datasources/local_data_source.dart';
import 'package:flutter_tries/features/posts/data/datasources/remote_data_source.dart';
import 'package:flutter_tries/features/posts/data/models/post_model.dart';
import 'package:flutter_tries/features/posts/domain/entities/post.dart';
import 'package:flutter_tries/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_tries/features/posts/domain/repositories/posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {

  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo
  });

  Future<Either<Failure, Unit>> getMessage(Future<Unit> Function() operation) async {
    if (await networkInfo.isConnected) {
      try {
        await operation();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } 
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts); // ? Caching posts
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(id: post.id, title: post.title, body: post.body);
    return await getMessage(() => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await getMessage(() => remoteDataSource.deletePost(postId));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(id: post.id, title: post.title, body: post.body);
    return await getMessage(() => remoteDataSource.updatePost(postModel));
  }

}