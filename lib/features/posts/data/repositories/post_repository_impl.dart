import 'package:flutter_tries/features/posts/data/datasources/local_data_source.dart';
import 'package:flutter_tries/features/posts/data/datasources/remote_data_source.dart';
import 'package:flutter_tries/features/posts/domain/entities/post.dart';
import 'package:flutter_tries/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_tries/features/posts/domain/repositories/posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {

  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  PostsRepositoryImpl({ required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    await remoteDataSource.getAllPosts();
    await localDataSource.getCachedPosts();
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    await remoteDataSource.addPost;
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    await remoteDataSource.deletePost;
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    await remoteDataSource.updatePost;
    throw UnimplementedError();
  }

}