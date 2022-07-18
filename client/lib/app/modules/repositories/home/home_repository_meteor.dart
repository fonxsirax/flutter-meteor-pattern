import 'package:arquiteturadesoftware/app/modules/models/post_model.dart';
import 'package:arquiteturadesoftware/app/modules/repositories/home/home_repository.dart';
import '../../../../utils/constants.dart';

class HomeRepositoryMeteor implements HomeRepository {
  @override
  Future<List<PostModel>> getPosts() async {
    List<PostModel> recoveredPosts = [];
    var snapshot = [];
    snapshot = await Constants.connection.call('getAllPosts');
    print("tamanho do snapshot = ${snapshot.length}");

    for (int i = 0; i < snapshot.length; i++) {
      var post = PostModel(
          tittle: snapshot[i]["tittle"],
          description: snapshot[i]["description"],
          date: snapshot[i]["createdAt"].toString(),
          id: snapshot[i]["_id"]);
      recoveredPosts.add(post);
    }

    return recoveredPosts;
  }
}
