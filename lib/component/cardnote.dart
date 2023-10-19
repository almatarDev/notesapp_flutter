import 'package:flutter/material.dart';

class CardNote extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final String content;
  final void Function() onDelete;
  const CardNote({
    Key? key,
    required this.onTap,
    required this.title,
    required this.content,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQto4lYhKepe6-QDJGmiBrOxx8YYki9zDn9z_cjaEuIQ-Bsv2mISDh9ArX8HZ6xVFX7Ilg&usqp=CAU',
                width: 100,
                height: 100,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                    onPressed: onDelete, icon: const Icon(Icons.delete)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
