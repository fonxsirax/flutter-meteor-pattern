import 'package:arquiteturadesoftware/app/modules/home_controller.dart';
import 'package:arquiteturadesoftware/app/modules/repositories/home/home_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

main(){
  HomeController controller = HomeController(HomeRepositoryImpl());

  setUp(() => {
    controller = HomeController(HomeRepositoryImpl())
  });

  group("Testando meu mock", () {
    test("Posts is empty", () {
      expect(controller.posts, isEmpty);
    });

    test("Posts is not empty", () async {
      await controller.getPosts();
      final posts = controller.posts;
      expect(posts.length, 10);
      expect(posts[0].tittle, "Tittle 0");
    });
  });
}