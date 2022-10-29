import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_tries/core/error/exceptions.dart';
import 'package:flutter_tries/features/posts/data/models/post_model.dart';
import 'package:flutter_tries/features/posts/domain/entities/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel>postModels);
}

const CASHED_POSTS = "CASHED_POSTS";

class LocalDataSourceImpl implements LocalDataSource {

  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({ required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
      sharedPreferences.setString(CASHED_POSTS, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CASHED_POSTS);
    if(jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonToPostModel) => PostModel.fromJson(jsonToPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}