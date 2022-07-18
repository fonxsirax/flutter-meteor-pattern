import 'package:arquiteturadesoftware/app/modules/components/createModel_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../home_controller.dart';

class CreateModelPage extends StatefulWidget {
  const CreateModelPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateModelPageState();
}

class _CreateModelPageState extends State<CreateModelPage> {
  @override
  Widget build(BuildContext context) {
    final controller =
        ModalRoute.of(context)!.settings.arguments as HomeController;
    Future<void> _submitForm(id, title, description) async {
      if (title.isEmpty || description.isEmpty) {
        return;
      }
      Constants.connection.call('createPostModel',
          args: [title, description]).catchError((_) {});
      Navigator.of(context).pop();
      controller.getPosts();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Criar novo post'),
      ),
      body: SafeArea(
        child: CreateModelForm(_submitForm),
      ),
    );
  }
}
