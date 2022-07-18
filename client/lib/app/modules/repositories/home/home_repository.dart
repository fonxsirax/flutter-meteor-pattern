import '../../models/post_model.dart';

abstract class HomeRepository {
  Future<List<PostModel>> getPosts();
}

class HomeRepositoryEmpty implements HomeRepository {
  @override
  Future<List<PostModel>> getPosts() {
    throw UnimplementedError();
  }
}
