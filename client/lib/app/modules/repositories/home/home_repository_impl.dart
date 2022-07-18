import 'package:arquiteturadesoftware/app/modules/models/post_model.dart';
import 'package:arquiteturadesoftware/app/modules/repositories/home/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<List<PostModel>> getPosts() async {
    await Future.delayed(Duration(seconds: 5));
    return List.generate(
        3,
        (index) => PostModel(
            tittle: "Tittle $index",
            description: "Description $index",
            id: index.toString()
        ));
  }
}
