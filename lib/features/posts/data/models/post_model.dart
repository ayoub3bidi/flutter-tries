import '../../domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({required int id, required String title, required String body}) : super(0, '', '');

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json['id'], title: json['title'], body: json['body']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'body': body};
  }
}