import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';

class ListItem extends StatelessWidget {
  final ItemModel data;
  final _colors = [Colors.green, Colors.greenAccent];
  final VoidCallback onRemove;
  ListItem({super.key, required this.data, required this.onRemove});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      //dense: true,
      leading: CircleAvatar(
        backgroundImage: AssetImage(
          data.image,
        ),
      ),
      tileColor: _colors[data.id % 2],
      title: Text(
        data.text,
        style: TextStyle(color: Colors.black.withOpacity(0.6)),
      ),
      trailing: data.isDeleting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: onRemove,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('X'),),
    );
  }
}
