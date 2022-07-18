import 'package:arquiteturadesoftware/app/modules/models/post_model.dart';
import 'package:arquiteturadesoftware/app/modules/repositories/home/home_repository.dart';
import 'package:flutter/cupertino.dart';

class HomeController {
  late final HomeRepository repository;
  final postValue = ValueNotifier<List<PostModel>>([]);

  List<PostModel> get posts => postValue.value;

  set posts(value) => postValue.value = value;

  HomeController(this.repository);

  Future<void> getPosts() async {
    posts = await repository.getPosts();
  }
}
