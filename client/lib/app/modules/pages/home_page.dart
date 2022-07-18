import 'package:arquiteturadesoftware/app/modules/home_controller.dart';
import 'package:arquiteturadesoftware/app/modules/models/post_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_routes.dart';
import '../../../utils/constants.dart';
import '../components/createModel_form.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Constants.currentcontroller;

  @override
  void initState() {
    print("get posts!");
    controller.getPosts();
    super.initState();
  }

  _openGeneratePostModel(BuildContext context) {
    Navigator.of(context)
        .pushNamed(AppRoutes.POST_CREATE, arguments: controller);
  }

  Future<void> _submitForm(id, tittle, description) async {
    if (tittle.isEmpty || description.isEmpty) {
      return;
    }
    Constants.connection.call('editPostModel',
        args: [id, tittle, description]).catchError((error) {
      print(error);
    });
    Navigator.of(context).pop();
    controller.getPosts();
  }

  _openEditPostModelModal(BuildContext context, id) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return CreateModelForm(_submitForm, id);
        });
  }

  _deleteMessage(id) {
    Constants.connection
        .call('deletePostModel', args: [id]).catchError((error) {
      print(error);
    });
    controller.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _openGeneratePostModel(context);
              },
              icon: Icon(key: Key('add'), Icons.add))
        ],
        title: const Text('Home Page'),
      ),
      body: ValueListenableBuilder<List<PostModel>>(
          valueListenable: controller.postValue,
          builder: (_, posts, __) {
            if (posts.isNotEmpty) {
              return ListView(
                  children: posts
                      .map((e) => ListTile(
                            key: Key(e.id),
                            trailing: IconButton(
                              icon: const Icon(Icons.restore_from_trash,
                                  color: Colors.red),
                              onPressed: () {
                                _deleteMessage(e.id);
                              },
                            ),
                            onTap: () {
                              _openEditPostModelModal(context, e.id);
                            },
                            title: Text(e.tittle,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            subtitle: Row(
                              children: [
                                Text(e.description,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)),
                                Text(e.date,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)),
                              ],
                            ),
                          ))
                      .toList());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
