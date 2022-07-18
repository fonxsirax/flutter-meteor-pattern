import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateModelForm extends StatefulWidget {
  final Future<void> Function(String, String, String) onSubmit;
  final String idIfEdit;

  CreateModelForm(this.onSubmit, [this.idIfEdit = ""]);

  @override
  _CreateModelForm createState() => _CreateModelForm();
}

class _CreateModelForm extends State<CreateModelForm> {
  final tittlePost = TextEditingController();
  final descriptionPost = TextEditingController();

  String get idIfEdit => widget.idIfEdit;

  @override
  Widget build(BuildContext context) {
    final _submitForm = widget.onSubmit;

    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: tittlePost,
              onSubmitted: (_) => {},
              decoration: const InputDecoration(
                labelText: 'Título do post',
              ),
            ),
            TextField(
              controller: descriptionPost,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => {},
              decoration: const InputDecoration(
                labelText: 'Descrição',
              ),
            ),
            SizedBox(height: 70),
            // SizedBox(
            //   height: 70,
            //   child: Row(
            //     children: <Widget>[
            //       Expanded(
            //         child: Text(
            //           _selectedDate == null
            //               ? 'Nenhuma data selecionada!'
            //               : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate!)}',
            //         ),
            //       ),
            //       TextButton(
            //         child: const Text(
            //           'Selecionar Data',
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         onPressed: _showDatePicker,
            //       )
            //     ],
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  child: Text(
                    'Publicar',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.button?.color,
                    ),
                  ),
                  onPressed: () {
                    _submitForm(
                        idIfEdit, tittlePost.text, descriptionPost.text);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
